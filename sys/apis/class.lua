return function(base)
    local c = { }
    if type(base) == "table" then
        for i, v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end
    c.__index = c
    setmetatable(c, {
        __call = function(class_tbl, ...)
            local obj = { }
            setmetatable(obj, c)
            if class_tbl.init then
                class_tbl.init(obj, ...)
            else
                if base and base.init then
                    base.init(obj, ...)
                end
            end
            return obj
        end
    })
    
    c.is_a = 
        function(self, klass)
            local m = getmetatable(self)
            while m do
                if m == klass then return true end
                m = m._base
            end
            return false
        end
    return c
end
