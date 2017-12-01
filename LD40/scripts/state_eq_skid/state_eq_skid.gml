
#region OnStateEnter

if (state_new == true)
{
    self.friction = 1;
    
    trace(object_get_name(self.object_index) + ", Enter Skid State.");
    trace("Skid: Enter State timer ", state_timer);
}

#endregion

if (self.speed <= 0.01)
{
    #region OnStateExit
    
    self.friction = 0;
    
    trace("Skid: Exit State timer ", state_timer);
    trace("Skid: state_var[0] ", state_var[0]);
    trace("Skid: state_var[1] ", state_var[1]);
    
    #endregion
    
    state_switch("Default");
}

x = wrap(x, 0, room_width);
y = wrap(y, 0, room_height);
