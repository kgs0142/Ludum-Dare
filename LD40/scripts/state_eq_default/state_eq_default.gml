

#region OnStateEnter

if (state_new == true)
{
    trace(object_get_name(self.object_index) + ", Enter Default State.");
    trace("Default: Enter State timer ", state_timer);
}

#endregion

if (keyboard_check(ord("W")) == true)
{
    self.vspeed -= 5;
}

if (keyboard_check(ord("A")) == true)
{
    self.hspeed -= 5;
}

if (keyboard_check(ord("S")) == true)
{
    self.vspeed += 5;
}

if (keyboard_check(ord("D")) == true)
{
    self.hspeed += 5;
}

if (keyboard_check_pressed(vk_space) == true)
{
    #region This could be OnStateExit
    
    trace("Default: Exit State timer ", state_timer);
    trace("Default: state_var[0] ", state_var[0]);
    trace("Default: state_var[1] ", state_var[1]);

    #endregion

    state_switch("Skid");
}

self.hspeed = clamp(self.hspeed, -20, 20);
self.vspeed = clamp(self.vspeed, -20, 20);

state_var[0] = self.hspeed;
state_var[1] = self.vspeed;

x = wrap(x, 0, room_width);
y = wrap(y, 0, room_height);
