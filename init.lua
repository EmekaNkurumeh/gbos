local version = _VERSION:match("%d+%.%d+")
package.path = 'rocks/share/lua/' .. version .. '/?.lua;rocks/share/lua/' .. version .. '/?/init.lua;' .. package.path
package.cpath = 'rocks/lib/lua/' .. version .. '/?.so;' .. package.cpath
