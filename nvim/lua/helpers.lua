local m = {}

function m.tbl_cat(table_1, table_2)
    local ret = table_1
    for _,e in pairs(table_2) do
        table.insert(ret, e)
    end
    return ret
end

function m.tbl_append(table_1, key, val)
    local ret = table_1
    ret[key] = val
    return ret
end

return m
