/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_static_destructible.gsc
***************************************************/

main() {
  var_0 = getentarray("static_destructible", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::static_destructible_think);
}

static_destructible_think() {
  self setcandamage(1);
  self.destroyed_fx_id = loadfx(self.script_parameters);
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 linkto(self);

  for (;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_5 != "MOD_MELEE" && var_5 != "MOD_IMPACT") {
      playfxontag(self.destroyed_fx_id, var_0, "tag_origin");
      var_6 = getent(self.target, "targetname");
      var_6 delete();
      self delete();
      wait 15;
      var_0 delete();
      break;
    }

    wait 0.05;
  }
}