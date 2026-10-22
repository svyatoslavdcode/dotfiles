local first_prompt = true

local p = clink.promptfilter(99)
function p:filter(prompt)
    if not prompt then return end

    if first_prompt then
        first_prompt = false
        prompt = prompt:gsub("^\r?\n", "")
    end

    if not prompt:match("%s$") then
        prompt = prompt .. " "
    end

    return prompt
end
