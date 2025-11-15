/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_ac130_amb.gsc
********************************/

main() {
  level.ambient_track["ac130"] = "ambient_ac130_int1";
  thread maps\_utility::set_ambient("ac130");
  maps\_ambient::ambientdelay("ac130", 3.0, 6.0);
  maps\_ambient::ambientevent("ac130", "elm_ac130_rattles", 4.0);
  maps\_ambient::ambientevent("ac130", "elm_ac130_beeps", 0.3);
  maps\_ambient::ambientevent("ac130", "elm_ac130_hydraulics", 1.0);
  maps\_ambient::ambientevent("ac130", "elm_ac130_metal_stress", 0.3);
  maps\_ambient::ambientevent("ac130", "null", 1.0);
  maps\_ambient::ambienteventstart("ac130");
  level waittill("action moment");
  maps\_ambient::ambienteventstart("action ambient");
}