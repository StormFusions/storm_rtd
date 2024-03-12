# RTD (Roll The Dice) System for Garry's Mod

## About
The RTD System adds a dynamic and fun element to Garry's Mod servers, allowing players to "roll the dice" for a chance to receive random effects. These effects can range from beneficial buffs to humorous or challenging changes that can turn the tide of gameplay in unexpected ways.

## Features
- **Global RTD Command:** Players can use the !rtd command to trigger a random effect.
- **Cooldown System:** To prevent abuse, each roll has a cooldown. The default setting is 60 seconds, but it's configurable.
- **Private and Global Messages:** The system informs the server of the player roll's outcome and private messages the player about time left and other restrictions.

## Installation
Clone this repository or download the ZIP file.
Extract the contents into your server's `garrysmod/addons` directory.
Restart your server, or load the addon manually via the server console.

## Configuration
The RTD system is highly configurable through the `rtd_config.lua` file. You can set the cooldown duration, and adjust messages sent to players.

## Usage
Players can initiate a roll by typing !rtd in the chat. The system will then randomly select an effect from the configured list and apply it to the player. If the player tries to roll again before their cooldown has expired, they'll receive a message indicating how much longer they need to wait.

## Adding Custom Effects
To add custom effects to the RTD system, modify the sv_rtdresults.lua file. Each effect should be a function that takes the player as an argument. For example:
```
local function IncreaseSpeed(ply)
  local s = ply:GetWalkSpeed()
  local i = math.random(100, 300)
  local t = math.random(5, 50)

  local speed = s+i
  ply:SetWalkSpeed(speed)

  timer.Simple(t, function()
    ply:SetWalkSpeed(s)
  end)

  RTDGlobalMessage(ply, " speed been increased by "..i.." for "..t.." seconds!")
end
```

Make sure to add the function to the table at the end of the file:

```
RTD.Results = {
  BurnThePlayer,
  LaunchPlayer,
  IncreaseHealth,
  IncreaseSpeed,
  ExplodePlayer,
  GivePoints,
  MegaExplode,
  SmallScalePlayer,
  WhipPlayer,
  GodMode,
  LowGravity,
  LargePlayerScale,
  Rocket,
}
```

## Commands
- **!rtd:** Roll the dice for a random effect.
- **!rtd reset:** (Admin only) Developer command to reset your cooldown

## Contributions
Contributions to the RTD system are welcome! If you have suggestions for new effects, improvements, or bug fixes, please submit an issue or pull request on GitHub.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

## Acknowledgments
The Garry's Mod community for continuous support and inspiration.
Contributors who have submitted issues, pull requests, or provided feedback.
