if ngx then
  return {
    md5 = ngx.md5
  }
end
local crypto = require("crypto")
local md5
md5 = function(str)
  return crypto.digest("md5", str)
end
return {
  md5 = md5
}
