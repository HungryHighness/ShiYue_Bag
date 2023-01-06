local _class = {}

function Class(className, super)
    ---@class Object
    local class_type = {}
    class_type.Ctor = false
    class_type.Super = super
    class_type.CName = className
    class_type.New = function(...)
        local obj = {}
        do
            local create
            create = function(c, ...)
                if c.Super then
                    create(c.Super, ...)
                end
                if c.Ctor then
                    c.Ctor(obj, ...)
                end
            end

            create(class_type, ...)
        end
        setmetatable(obj, { __index = _class[class_type] })
        return obj
    end
    local vtbl = {}
    _class[class_type] = vtbl

    setmetatable(class_type, { __newindex = function(t, k, v)
        vtbl[k] = v
    end
    })

    if super then
        setmetatable(vtbl, { __index = function(t, k)
            local ret = _class[super][k]
            vtbl[k] = ret
            return ret
        end
        })
    end

    return class_type
end