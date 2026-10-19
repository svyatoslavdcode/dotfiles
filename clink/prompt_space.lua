local p = clink.promptfilter(99)
function p:filter(prompt)
    if prompt and not prompt:match("%s$") then
        return prompt .. " "
    end
end
