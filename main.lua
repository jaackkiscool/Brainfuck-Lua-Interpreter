if not io then
    error("io is not found")
end
if not string.find(_VERSION, "Lua 5") then
    error("support is provided only from lua 5x")
end  
local a =
    setmetatable(
    {},
    {__index = function(self, ...)
            if string.lower(..., "r") then
                return function()
                    local b = self[#self]
                    table.remove(self, #self)
                    return b
                end
            end
        end}
)
local c = io.open("code.bf")
local d = c:read()
c:close()
d = d:gsub("[%s\n%w]+", "")
local e = {}
local f = 0
local g = ""
local h = 0
z = {[">"] = function()
        f = f + 1
    end, ["<"] = function()
        f = f - 1
    end, ["."] = function()
        g = g .. string.char(e[f] or 0)
    end, ["+"] = function()
        e[f] = (e[f] or 0) + 1
    end, ["-"] = function()
        e[f] = (e[f] or 0) > 0 and (e[f] or 0) - 1 or 0
    end, ["["] = function()
        if e[f] == 0 then
            while d:sub(h, h) ~= "]" and h <= #d do
                h = h + 1
            end
        else
            a[#a + 1] = h
        end
    end, ["]"] = function()
        if #a > 0 then
            h = a.r()
            h = h - 1
        else
            h = h + 1
        end
    end}
while h < #d do
    h = h + 1
    local i = d:sub(h, h)
    assert(z[i], "Invalid Instruction: " .. i)
    z[i]()
end
print(g)
