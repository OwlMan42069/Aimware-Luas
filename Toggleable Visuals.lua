-- =======================
-- Parents / Sections
-- =======================
-- Overlay parents
local ev_box      = gui.Reference("Visuals", "Enemy", "Overlay", "Box")
local ev_ammo     = gui.Reference("Visuals", "Enemy", "Overlay", "Ammo")
local ev_health   = gui.Reference("Visuals", "Enemy", "Overlay", "Health")
local ev_name     = gui.Reference("Visuals", "Enemy", "Overlay", "Name")
local ev_skeleton = gui.Reference("Visuals", "Enemy", "Overlay", "Skeleton")
local ev_armor    = gui.Reference("Visuals", "Enemy", "Overlay", "Armor")
local ev_money    = gui.Reference("Visuals", "Enemy", "Overlay", "Money")
local ev_ping     = gui.Reference("Visuals", "Enemy", "Overlay", "Ping")
local ev_flags    = gui.Reference("Visuals", "Enemy", "Overlay", "Flags")
local ev_barrel   = gui.Reference("Visuals", "Enemy", "Overlay", "Barrel")
local ev_weapon   = gui.Reference("Visuals", "Enemy", "Overlay", "Weapon")
local ev_overlay_root = gui.Reference("Visuals", "Enemy", "Overlay")

-- Chams parent
local ev_chams    = gui.Reference("Visuals", "Enemy", "Chams")

-- =======================
-- Helpers (overlay)
-- =======================
local function to_bool(v)
    return v == true or v == 1 or v == "On"
end

local function add_checkbox(parent, id, label, cvar)
    local init = to_bool(gui.GetValue(cvar))
    local cb = gui.Checkbox(parent, id, label, init)
    return { cb = cb, cvar = cvar, last = init }
end

-- =======================
-- Overlay: checkbox registry
-- =======================
local enemyVisuals = {
    add_checkbox(ev_box,      "enable.evbox",      "Toggle", "esp.enemy.box.enable"),
    add_checkbox(ev_ammo,     "enable.evammo",     "Toggle", "esp.enemy.ammo.enable"),
    add_checkbox(ev_health,   "enable.evhealth",   "Toggle", "esp.enemy.health.enable"),
    add_checkbox(ev_name,     "enable.evname",     "Toggle", "esp.enemy.name.enable"),
    add_checkbox(ev_skeleton, "enable.evskeleton", "Toggle", "esp.enemy.skeleton.enable"),
    add_checkbox(ev_armor,    "enable.evarmor",    "Toggle", "esp.enemy.armor.enable"),
    add_checkbox(ev_money,    "enable.evmoney",    "Toggle", "esp.enemy.money.enable"),
    add_checkbox(ev_ping,     "enable.evping",     "Toggle", "esp.enemy.ping.enable"),
    add_checkbox(ev_flags,    "enable.evflags",    "Toggle", "esp.enemy.flags.enable"),
    add_checkbox(ev_barrel,   "enable.evbarrel",   "Toggle", "esp.enemy.barrel.enable"),
    add_checkbox(ev_weapon,   "enable.evweapon",   "Toggle", "esp.enemy.weapon.enable"),
}

local function overlay_any_on()
    for _, it in ipairs(enemyVisuals) do
        if it.cb:GetValue() then return true end
    end
    return false
end

-- =======================
-- Helpers (chams styles)
-- =======================
-- 0=Off, 1=Flat, 2=Textured, 3=Glow, 4=Plastic, 5=Metallic
local name_to_idx = { Off=0, Flat=1, Textured=2, Glow=3, Plastic=4, Metallic=5 }
local idx_to_name = { [0]="Off", [1]="Flat", [2]="Textured", [3]="Glow", [4]="Plastic", [5]="Metallic" }

local function clamp_style(i)
    if type(i) ~= "number" then return 0 end
    if i < 0 then return 0 elseif i > 5 then return 5 end
    return i
end

local function read_style(cvar)
    local v = gui.GetValue(cvar)
    if type(v) == "number" then
        return clamp_style(v)
    elseif type(v) == "string" then
        return clamp_style(name_to_idx[v] or 0)
    end
    return 0
end

local function write_style(cvar, idx)
    idx = clamp_style(idx)
    gui.SetValue(cvar, idx)
    if read_style(cvar) ~= idx then
        gui.SetValue(cvar, idx_to_name[idx] or "Off")
    end
end

-- Toggle entry: checkbox that switches Off <-> last non-Off style
local function add_chams_toggle(parent, id, label, cvar)
    local init_style = read_style(cvar)
    local init_on    = (init_style ~= 0)
    local cb         = gui.Checkbox(parent, id, label, init_on)
    return {
        cb = cb,
        cvar = cvar,
        last_cb = init_on,
        remember = (init_style ~= 0 and init_style or 1), -- default Flat if none yet
        last_seen_style = init_style
    }
end

-- =======================
-- Chams: toggle registry
-- =======================
local chamsToggles = {
    add_chams_toggle(ev_chams, "toggle.ev.model.visible",       "Model Visible",         "esp.enemy.model.visible"),
    add_chams_toggle(ev_chams, "toggle.ev.model.occluded",      "Model Occluded",        "esp.enemy.model.occluded"),
    add_chams_toggle(ev_chams, "toggle.ev.model.glow",          "Model Glow",            "esp.enemy.model.glow"),
    add_chams_toggle(ev_chams, "toggle.ev.attachments.visible", "Attachments Visible",   "esp.enemy.attachments.visible"),
    add_chams_toggle(ev_chams, "toggle.ev.attachments.occluded","Attachments Occluded",  "esp.enemy.attachments.occluded"),
    add_chams_toggle(ev_chams, "toggle.ev.ragdoll.visible",     "Ragdoll Visible",       "esp.enemy.ragdoll.visible"),
    add_chams_toggle(ev_chams, "toggle.ev.ragdoll.occluded",    "Ragdoll Occluded",      "esp.enemy.ragdoll.occluded"),
}

local function chams_any_on()
    for _, e in ipairs(chamsToggles) do
        if read_style(e.cvar) ~= 0 or e.cb:GetValue() then return true end
    end
    return false
end

-- =======================
-- Master toggles (UI)
-- =======================
local overlay_master = gui.Checkbox(ev_overlay_root, "enable.ev.master", "Enable All Enemy Overlay", overlay_any_on())
local chams_master   = gui.Checkbox(ev_chams,        "enable.chams.master", "Enable All Enemy Chams", chams_any_on())

local last_overlay_master = overlay_master:GetValue()
local last_chams_master   = chams_master:GetValue()

-- =======================
-- Single change-only Draw watcher
-- =======================
callbacks.Register("Draw", function()
    -- --------- Master: Overlay ---------
    local om = overlay_master:GetValue()
    if om ~= last_overlay_master then
        last_overlay_master = om
        -- set every overlay checkbox to master state; per-item logic below will push CVars
        for _, it in ipairs(enemyVisuals) do
            it.cb:SetValue(om)
        end
    end

    -- Overlay per-item: apply only when a checkbox changes
    for _, item in ipairs(enemyVisuals) do
        local current = item.cb:GetValue()
        if current ~= item.last then
            gui.SetValue(item.cvar, current)
            item.last = current
        end
    end

    -- --------- Master: Chams ---------
    local cm = chams_master:GetValue()
    if cm ~= last_chams_master then
        last_chams_master = cm
        if cm then
            -- Turn ON: restore each to its remembered style
            for _, e in ipairs(chamsToggles) do
                e.cb:SetValue(true)
                write_style(e.cvar, e.remember or 1)
                e.last_seen_style = read_style(e.cvar)
                e.last_cb = true
            end
        else
            -- Turn OFF: remember current non-Off, then set Off
            for _, e in ipairs(chamsToggles) do
                local cur = read_style(e.cvar)
                if cur ~= 0 then e.remember = cur end
                e.cb:SetValue(false)
                write_style(e.cvar, 0)
                e.last_seen_style = 0
                e.last_cb = false
            end
        end
    end

    -- Chams per-item: learn engine changes + toggle Off <-> remembered style
    for _, e in ipairs(chamsToggles) do
        -- learn direct combobox changes (outside our UI)
        local eng_style = read_style(e.cvar)
        if eng_style ~= e.last_seen_style then
            e.last_seen_style = eng_style
            if eng_style ~= 0 then
                e.remember = eng_style
                e.cb:SetValue(true);  e.last_cb = true
            else
                e.cb:SetValue(false); e.last_cb = false
            end
        end

        -- checkbox changed → flip Off <-> remembered style
        local want = e.cb:GetValue()
        if want ~= e.last_cb then
            if want then
                write_style(e.cvar, e.remember or 1)
                e.last_seen_style = read_style(e.cvar)
            else
                local cur = read_style(e.cvar)
                if cur ~= 0 then e.remember = cur end
                write_style(e.cvar, 0)
                e.last_seen_style = 0
            end
            e.last_cb = want
        end
    end
end)
