git = require 'git-utils'

readGitInfo = (path) ->
  repository = git.open path
  [..., repositoryName] = repository.getConfigValue('remote.origin.url').split "/"
  result =
    branch: repository.getShortHead()
    dirty: Object.keys(repository.getStatus()).length != 0
    repositoryName: repositoryName

  repository.release()
  return result

module.exports = (path) ->
  # Indicates that this task will be async.
  # Call the `callback` to finish the task
  callback = @async()
  emit('result', readGitInfo(path))
  callback()
