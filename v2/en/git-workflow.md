<!---
    @title         Git Workflow
    @creator       Yichun Zhang
    @created       2020-06-27 16:18 GMT
--->

# Commit log message format

The git commit log title should end with a dot.

The sentence should not start with an uppercase letter unless it is a special word like a class name.

Use simple past tense for the predicate verb in the title if it is the committer’s action, like "fixed an issue", "optimized a thing", or it is describing a past state for a fixed bug, like "memory leak would happen when …" and "the flag was incorrectly cleared".

Use simple present tense to describe a current state of the program, like "now the class always initializes properly".

The log title should use one of the following topic words:

* `change`: backward incompatible changes.
* `bugfix`: bug fixes.
* `refactor`: code refactoring and other code rearrangement.
* `doc`: documentation changes including code comments.
* `tests`: test suite changes.
* `optimize`: performance optimizations.
* `feature`: implementing a new feature.
* `editor`: code editor related configurations.
* `style`: coding style changes.

The topic words should always be followed by a colon and a space.

You can check out the existing git log history for more examples.

# Workflow

You should always fork the Git repositories under your own GitHub ID and commit your own changes to your own branch of your own fork.

After you finish you work, create a GitHub pull request against the Git repository. Every pull request must pass the repository maintainers’ code review before it can get merged.

Never do `git merge` in your own branch unless you are sure it will be a fast-forwarding. This is because otherwise Git would introduce a
"merge commit" which makes the history nonlinear. Use `git rebase` instead and use it often to synchronize with the mainline master of the
Git repositories.

Do not squash or amend your existing commits in your branch during the review process. Always commit any new changes incrementally in separate commits to the same branch of yours. It is the administrator's responsibility to squash commits right before merging into the master.

Each pull request should be atomic and should generally exclude any unrelated changes. It should generally be avoided to have pending pull requests depend on each other for the same code repository unless absolutely necessary.
