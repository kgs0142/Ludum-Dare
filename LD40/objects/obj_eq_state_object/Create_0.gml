///@description State Machine Init

state_machine_init();

state_create("Default", state_eq_default);
state_create("Skid", state_eq_skid);

state_init("Default");