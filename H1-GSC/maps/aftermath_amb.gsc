/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\aftermath_amb.gsc
********************************/

main() {
  level.ambient_track["exterior"] = "ambient_aftermath_ext0";
  thread maps\_utility::set_ambient("exterior");
  maps\_ambient::ambientdelay("exterior", 8.0, 20.0);
  maps\_ambient::ambientevent("exterior", "elm_wind_leafy", 6.0);
  maps\_ambient::ambientevent("exterior", "elm_rubble", 6.0);
  maps\_ambient::ambientevent("exterior", "elm_industry", 6.0);
  maps\_ambient::ambientevent("exterior", "elm_stress", 6.0);
  maps\_ambient::ambientevent("exterior", "elm_metal_stress", 6.0);
  maps\_ambient::ambientevent("exterior", "null", 1.0);
  maps\_ambient::ambienteventstart("interior_vehicle");
  level waittill("action moment");
  maps\_ambient::ambienteventstart("action ambient");
}