# frozen_string_literal: true

module Dependabot
  class Publish
    include ::Straw::Memoizable

    attr_reader :dependency, :git, :head, :base

    def initialize(dependency, git: Dependabot::Git.for(dependency))
      @dependency = dependency
      @git = git
      @head = "dependanot/#{dependency.package_manager}/#{dependency.name}"
      @base = git.repo.head.name
    end

    def update!(push: false)
      git.checkout(branch: head)
      ::Spandx::Core::Plugin.enhance(dependency)
      return if git.patch.empty? || !push

      Dependabot.logger.debug(git.patch)
      git.commit(all: true, message: commit_message)
      git.push(remote: "origin", branch: head)

      Dependabot.octokit.create_pull_request(
        GitHub.name_with_owner_from(git.repo.remotes["origin"].url),
        base,
        head,
        title,
        description
      )
    ensure
      git.repo.checkout_head(strategy: :force)
      git.repo.checkout(base)
    end

    private

    def title
      memoize(:title) do
        "chore(deps): bump #{dependency.name} from #{dependency.version}"
      end
    end

    def commit_message
      memoize(:commit_message) do
        <<~COMMIT
          #{title}

          #{description}
        COMMIT
      end
    end

    def description
      memoize(:description) do
        ERB
          .new(File.read(File.join(__dir__, "templates/pull.md.erb")))
          .result(binding)
      end
    end
  end
end
