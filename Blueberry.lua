--[[

Copyright © 2025, Quenala of Asura
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Blueberry nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL QUENALA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

]]

_addon.name = 'Blueberry'
_addon.version = '1.1'
_addon.author = 'Quenala'
_addon.commands = {'blueberry'}

texts = require('texts')

--  HUD position
PosisionX = 300
PositionY = 300

local galli_total = 0

windower.register_event('incoming text', function(original, modified, original_mode, modified_mode, blocked)
    local galli_gain = original:match("received (%d+) gallimaufry for a total of")
    if galli_gain then
        galli_total = galli_total + tonumber(galli_gain)
		blueberry_hud:text('Gallimaufry: '..galli_total)
    end
end)

windower.register_event('addon command', function(...)
    local args = {...}
    if not args[1] then return end

    local cmd = args[1]:lower()
 
    if cmd == 'reset' then
        galli_total = 0
        windower.add_to_chat(207, '[Blueberry] Session total reset to 0.')
		blueberry_hud:text(' ')
    else
        windower.add_to_chat(207, '[Blueberry] Commands:')
        windower.add_to_chat(207, '  //blueberry reset  - Reset Sortie session counter')
    end
end)

blueberry_config = {
	pos = {
		x = PosisionX, 
		y = PositionY
	},
	bg = 
		{visible = false, alpha = 40
	},
	padding = 8,
	text = {
		font = 'consolas',
		size = 10,
		stroke = {width = 2, alpha = 255},
		Fonts = {'consolas'},
	},
	flags = {
		draggable = true,
		blocking = false,
	}
}
 
blueberry_hud = texts.new(blueberry_config)
blueberry_hud:show()