local Class = require "lib.hump.class"

local RingStruct = Class {
    init = function(self)
        self.elements = {}
        self.head = 1
        self.current = 1
    end
}

function RingStruct:push(item)
    self.elements[self.head] = item
    self.head = self.head + 1
    return self
end

function RingStruct:next()
    self.current = self.current + 1
    if self.current > #self.elements then
        self.current = 1
    end
    return self.elements[self.current]
end

function RingStruct:get(ind)
    return self.elements[ind]
end

function RingStruct:prev()
    self.current = self.current - 1
    if self.current < 1 then
        self.current = #self.elements
    end
    return self.elements[self.current]
end

return RingStruct
