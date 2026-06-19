local m = {}

---@param table_1 table
---@param table_2 table
---@return table
---Concatenates `table_1` and `table_2` w/o side effects
 m.tbl_cat = function(table_1, table_2)
    local ret = table_1
    for _,e in pairs(table_2) do
        table.insert(ret, e)
    end
    return ret
end

---@param table table
---@return table
---Append a `key`,`val` pair to `table`
m.tbl_append = function(table, key, val)
    local ret = table
    ret[key] = val
    return ret
end

---@param table_1 table
---@param table_2 table
---@return table
---Remove all occurences of an element from `table_2` in `table_1`
m.tbl_remove_vals = function(table_1, table_2)
    local ret = {}
    for _,e in pairs(table_1) do
        for _,f in pairs(table_2) do
            if e == f then
                goto continue
            end
        end
        table.insert(ret, e)
        ::continue::
    end
    return ret
end

return m
