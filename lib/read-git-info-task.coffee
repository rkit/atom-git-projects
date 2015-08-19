git = require 'git-utils'
_path = require 'path'

readGitInfo = (path) ->
  repository = git.open path
  repositoryUrl = repository.getConfigValue('remote.origin.url')
  if (repositoryUrl)
    [..., repositoryName] = repositoryUrl.split "/"
  else
    repositoryName = _path.basename(path)

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
