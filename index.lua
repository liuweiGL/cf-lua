---
--- Generated by wjlin0(https://github.com/wjlin0)
--- Created by wjlin0.
--- DateTime: 2023/11/25 13:21
---
--- @作者     : wjlin0
--- @博客     : https://wjlin0.com
--[[ 注意事项
 1. 免责声明
   由于传播、利用此工具所提供的信息而造成的任何直接或者间接的后果及损失，均由使用者本人负责。本工具仅限学习开发编程Lua使用。
 2. 每次改动后关闭 ctrl + s 保存一下配置
 3. 配置完成保存后，在当前界面若没有出现 timeout = * 的字样时，联系作者。
 4. 若配置成功后，完成第三个，在游戏中不生效，可将GHUB关闭后，按管理员重新运行。
 5. 若要长期以管理员运行，请联系作者。
 6. 若鼠标只有两位侧位键，尽量开启的功能为两个
 7. 配套文档： https://github.com/wjlin0/cf-lua
]] --
Version = "v1.4" --- 脚本版本

--[[ GPW 鼠标宏配置按钮
  LEFT_PRIMARY --> 鼠标左键
  RIGHT_PRIMARY --> 鼠标右键
  MIDDLE --> 鼠标中滑轮键
  LEFT_X1 --> 鼠标左下键  需要把按钮默认的指令打开
  LEFT_X2 --> 鼠标左上键  需要把按钮默认的指令打开
  RIGHT_X1  --> 鼠标右下键
  RIGHT_X2  --> 鼠标右上键
  NONE --> 表示不生效
]]
MOUSE_BUTTON_MAPPING = {
    NONE = 0,
    LEFT_PRIMARY = 1,
    RIGHT_PRIMARY = 2,
    MIDDLE = 3,
    -- x1/x2 分别是从手心往手指方向看的按钮
    LEFT_X1 = 4,
    LEFT_X2 = 5,
    RIGHT_X1 = 7,
    RIGHT_X2 = 8
}
-- IsMouseButtonPressed 的值映射
PRESSED_BUTTON_MAPPING = {
    [MOUSE_BUTTON_MAPPING.LEFT_PRIMARY] = 1,
    [MOUSE_BUTTON_MAPPING.RIGHT_PRIMARY] = 3,
    [MOUSE_BUTTON_MAPPING.MIDDLE] = 2,
    [MOUSE_BUTTON_MAPPING.LEFT_X1] = 4,
    [MOUSE_BUTTON_MAPPING.LEFT_X2] = 5,
    -- 右边两个编程键不支持，不要使用
    [MOUSE_BUTTON_MAPPING.RIGHT_X1] = 7,
    [MOUSE_BUTTON_MAPPING.RIGHT_X2] = 8
}

USP_ARG = MOUSE_BUTTON_MAPPING.NONE --- USP速点按键
LIAN_YU_ARG = MOUSE_BUTTON_MAPPING.LEFT_X2 --- 炼狱速点
CTRL_ARG = MOUSE_BUTTON_MAPPING.NONE --- 闪蹲按键
INSTANT_SNIPER_ARG = MOUSE_BUTTON_MAPPING.NONE --- 一键瞬狙
RAG_ARG = MOUSE_BUTTON_MAPPING.NONE --- 小碎步 配合w
GHOST_JUMP_ARG = MOUSE_BUTTON_MAPPING.NONE --- 鬼跳
M4A1_THOR_SPEED_POINT_ARG = MOUSE_BUTTON_MAPPING.NONE --- M4雷神速点
AK47_SPEED_POINT_ARG = MOUSE_BUTTON_MAPPING.NONE --- AK47速点

--[[ 延迟相关的全局变量
 延迟区间 ，快很了，区间小了 会被封
 USP 建议 35 - 65 之间
 COP 建议 35 - 65 之间
 炼狱 建议 20 - 30 之间
 闪蹲 建议 35 - 50 之间
 瞬狙 建议 35 - 50 之间
 碎步 建议 60 - 70 之间
 鬼跳 建议 15 - 25 之间 只测试了几把 虽然稳定但是不知道封号不
 雷神 建议 25 - 50 之间
 AK  建议 25 - 50 之间
]]
G_TIME = {
    ["USP_INTERVAL"] = {29, 45}, -- USP/COP
    ["LIAN_YU_INTERVAL"] = {20, 40}, -- 炼狱速点
    ["CTRL_INTERVAL"] = {35, 50}, -- 闪蹲延迟
    ["INSTANT_SNIPER_INTERVAL"] = {35, 50}, -- 一键瞬狙延迟
    ["RAG_INTERVAL"] = {60, 70}, -- 小碎步延迟
    ["GHOST_JUMP_INTERVAL"] = {15, 25}, -- 鬼跳延迟
    ["M4A1_THOR_SPEED_POINT_INTERVAL"] = {25, 50}, -- M4雷神速点延迟
    ["AK47_SPEED_POINT_INTERVAL"] = {25, 50} -- AK47速点延迟
}

--- RandomSleep(),生成随机睡眠 -
function RandomSleep(min, max)
    local tmp = 0
    if (min >= max) then
        tmp = min
        min = max
        max = tmp
    end
    num = math.random(min, max)
    -- OutputLogMessage("timeout = %d\n", num)
    Sleep(num)
end

--- M4a1_Thor_Speed_Point(),M4雷神速点 -
function M4a1_Thor_Speed_Point(event, arg)
    -- OutputLogMessage("M4a1_Thor_Speed_Point\n")
    repeat
        PressMouseButton(1)
        RandomSleep(G_TIME["M4A1_THOR_SPEED_POINT_INTERVAL"][1], G_TIME["M4A1_THOR_SPEED_POINT_INTERVAL"][2])
        ReleaseMouseButton(1)
        RandomSleep(G_TIME["M4A1_THOR_SPEED_POINT_INTERVAL"][1] + 80, G_TIME["M4A1_THOR_SPEED_POINT_INTERVAL"][2] + 80)
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end

function Ak47_Speed_Point(event, arg)
    -- OutputLogMessage("Ak47_Speed_Point\n")
    repeat
        PressMouseButton(1)
        RandomSleep(G_TIME["AK47_SPEED_POINT_INTERVAL"][1], G_TIME["AK47_SPEED_POINT_INTERVAL"][2])
        ReleaseMouseButton(1)
        RandomSleep(G_TIME["AK47_SPEED_POINT_INTERVAL"][1] + 85, G_TIME["AK47_SPEED_POINT_INTERVAL"][2] + 90)
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end

--- Usp(),随机速点 -
function Usp(event, arg)
    repeat
        PressMouseButton(1)
        RandomSleep(G_TIME["USP_INTERVAL"][1], G_TIME["USP_INTERVAL"][2])
        ReleaseMouseButton(1)
        RandomSleep(G_TIME["USP_INTERVAL"][1], G_TIME["USP_INTERVAL"][2])
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end
--- LianYu(), 炼狱速点
function LianYu(event, arg)
    -- OutputLogMessage("LianYu\n")
    repeat
        PressMouseButton(1)
        RandomSleep(G_TIME["LIAN_YU_INTERVAL"][1] + 50, G_TIME["LIAN_YU_INTERVAL"][2] + 80)
        ReleaseMouseButton(1)
        RandomSleep(G_TIME["LIAN_YU_INTERVAL"][1], G_TIME["LIAN_YU_INTERVAL"][2])
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end

--- Ctrl() 闪蹲
function Ctrl(event, arg)
    repeat
        -- OutputLogMessage("event = %s\narg = %d\n",event,arg)
        PressKey("lctrl")
        RandomSleep(G_TIME["CTRL_INTERVAL"][1], G_TIME["CTRL_INTERVAL"][2])
        ReleaseKey("lctrl")
        RandomSleep(G_TIME["CTRL_INTERVAL"][1], G_TIME["CTRL_INTERVAL"][2])
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end

--- Instant_Sniper() 一键瞬狙
function Instant_Sniper(event, arg)
    PressMouseButton(3)
    RandomSleep(G_TIME["INSTANT_SNIPER_INTERVAL"][1], G_TIME["INSTANT_SNIPER_INTERVAL"][2])
    ReleaseMouseButton(3)
    RandomSleep(G_TIME["INSTANT_SNIPER_INTERVAL"][1] - 10, G_TIME["INSTANT_SNIPER_INTERVAL"][2] - 10)
    PressMouseButton(1)
    RandomSleep(G_TIME["INSTANT_SNIPER_INTERVAL"][1] - 10, G_TIME["INSTANT_SNIPER_INTERVAL"][2] - 10)
    ReleaseMouseButton(1)
    PressKey("3")
    RandomSleep(45, 55)
    ReleaseKey("3")
    RandomSleep(45, 55)
    PressKey("1")
    RandomSleep(45, 55)
    ReleaseKey("1")
    RandomSleep(45, 55)
    PressKey("1")
    RandomSleep(45, 55)
    ReleaseKey("1")
    RandomSleep(45, 55)
end

--- Rag() 碎步
function Rag(event, arg)
    repeat
        -- OutputLogMessage("event = %s\narg = %d\n",event,arg)
        PressKey("w")
        RandomSleep(G_TIME["RAG_INTERVAL"][1], G_TIME["RAG_INTERVAL"][2])
        ReleaseKey("w")
        RandomSleep(G_TIME["RAG_INTERVAL"][1], G_TIME["RAG_INTERVAL"][2])
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
end

--- GhostJump() 鬼跳 -
function GhostJump(event, arg)
    PressKey("spacebar")
    RandomSleep(G_TIME["GHOST_JUMP_INTERVAL"][1], G_TIME["GHOST_JUMP_INTERVAL"][2])
    ReleaseKey("spacebar")
    RandomSleep(G_TIME["GHOST_JUMP_INTERVAL"][1], G_TIME["GHOST_JUMP_INTERVAL"][2])
    PressKey("lctrl")
    RandomSleep(G_TIME["GHOST_JUMP_INTERVAL"][1], G_TIME["GHOST_JUMP_INTERVAL"][2])
    repeat
        -- OutputLogMessage("event = %s\narg = %d\n",event,arg)
        PressKey("spacebar")
        RandomSleep(G_TIME["GHOST_JUMP_INTERVAL"][1], G_TIME["GHOST_JUMP_INTERVAL"][2])
        ReleaseKey("spacebar")
        RandomSleep(G_TIME["GHOST_JUMP_INTERVAL"][1], G_TIME["GHOST_JUMP_INTERVAL"][2])
    until not IsMouseButtonPressed(PRESSED_BUTTON_MAPPING[arg])
    ReleaseKey("lctrl")
end

function Event(event, arg, action)
    -- OutputLogMessage("event = %s arg = %d action = %d  equals = %s\n", event, arg, action, arg == action)
    return event == "MOUSE_BUTTON_PRESSED" and arg == action
end

-- 禁止左键触发
EnablePrimaryMouseButtonEvents(false)

--- OnEvent(),事件触发函数 -
function OnEvent(event, arg)
    local USP_EVENT = Event(event, arg, USP_ARG)
    local CTRL_EVENT = Event(event, arg, CTRL_ARG)
    local INSTANT_SNIPER_EVENT = Event(event, arg, INSTANT_SNIPER_ARG)
    local LIAN_YU_EVENT = Event(event, arg, LIAN_YU_ARG)
    local RAG_EVENT = Event(event, arg, RAG_ARG)
    local GHOST_JUMP_EVENT = Event(event, arg, GHOST_JUMP_ARG)
    local M4A1_THOR_SPEED_POINT_EVENT = Event(event, arg, M4A1_THOR_SPEED_POINT_ARG)
    local AK47_SPEED_POINT_EVENT = Event(event, arg, AK47_SPEED_POINT_ARG)
    -- OutputLogMessage("event = %s, button = %s\n", event, arg)
    -- OutputLogMessage("USP_EVENT= %s\n",USP_EVENT)
    -- OutputLogMessage("LIAN_YU_EVENT= %s\n",LIAN_YU_EVENT)
    -- OutputLogMessage("CTRL_EVENT= %s\n",CTRL_EVENT)
    -- OutputLogMessage("INSTANT_SNIPER_EVENT= %s\n",INSTANT_SNIPER_EVENT)
    -- OutputLogMessage("RAG_EVENT= %s\n",RAG_EVENT)
    -- OutputLogMessage("GHOST_JUMP_EVENT= %s\n",GHOST_JUMP_EVENT)
    -- OutputLogMessage("M4A1_THOR_SPEED_POINT_EVENT= %s\n",M4A1_THOR_SPEED_POINT_EVENT)
    -- OutputLogMessage("AK47_SPEED_POINT_EVENT= %s\n",AK47_SPEED_POINT_EVENT)

    if (USP_EVENT) then
        Usp(event, arg)
    elseif (LIAN_YU_EVENT) then
        LianYu(event, arg)
    elseif (CTRL_EVENT) then
        Ctrl(event, arg)
    elseif (INSTANT_SNIPER_EVENT) then
        Instant_Sniper(event, arg)
    elseif (RAG_EVENT) then
        Rag(event, arg)
    elseif (GHOST_JUMP_EVENT) then
        GhostJump(event, arg)
    elseif (M4A1_THOR_SPEED_POINT_EVENT) then
        M4a1_Thor_Speed_Point(event, arg)
    elseif (AK47_SPEED_POINT_EVENT) then
        Ak47_Speed_Point(event, arg)
    end
end
