/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat.csc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\aats\ammomods\ammomod_brainrot;
#using scripts\zm_common\aats\ammomods\ammomod_cryofreeze;
#using scripts\zm_common\aats\ammomods\ammomod_deadwire;
#using scripts\zm_common\aats\ammomods\ammomod_electriccherry;
#using scripts\zm_common\aats\ammomods\ammomod_napalmburst;
#using scripts\zm_common\aats\ammomods\ammomod_shatterblast;
#namespace zm_aat;

function private autoexec __init__system__() {
  system::register(#"zm_aat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  level.aat_initializing = 1;
  level aat::function_571fceb("ammomod_brainrot", &ammomod_brainrot::init_brainrot);
  level aat::function_571fceb("ammomod_cryofreeze", &ammomod_cryofreeze::init_cryofreeze);
  level aat::function_571fceb("ammomod_deadwire", &ammomod_deadwire::init_deadwire);
  level aat::function_571fceb("ammomod_napalmburst", &ammomod_napalmburst::init_napalmburst);
  level aat::function_571fceb("ammomod_electriccherry", &ammomod_electriccherry::init_electriccherry);
  level aat::function_571fceb("ammomod_shatterblast", &ammomod_shatterblast::init_shatterblast);
  clientfield::register("toplayer", "" + # "hash_10f9eacd143d57ae", 1, 1, "int", &function_6ab142a9, 1, 0);
  clientfield::register("toplayer", "ammomod_play_rob_tier", 15000, 3, "int", &function_cc40e7e2, 1, 0);
  clientfield::register("toplayer", "ammomod_cryofreeze_idle", 1, 1, "int", &function_c62bfdf2, 1, 0);
  clientfield::register("toplayer", "ammomod_napalmburst_idle", 1, 1, "int", &function_f745370f, 1, 0);
  clientfield::register("toplayer", "ammomod_brainrot_idle", 1, 1, "int", &function_7c325bd9, 1, 0);
  clientfield::register("toplayer", "ammomod_deadwire_idle", 1, 1, "int", &function_5cc517e6, 1, 0);
  level aat::function_2b3bcce0();
}

function function_74b823de(tier = 1) {
  switch (tier) {
    case 1:
    case 2:
      return "rob_ammo_mod_level_1";
    case 3:
      return "rob_ammo_mod_level_2";
    case 4:
      return "rob_ammo_mod_level_3";
    case 5:
      return "rob_ammo_mod_level_4";
    case 6:
      return "rob_ammo_mod_level_5";
  }

  return "rob_ammo_mod_level_1";
}

function function_ac9a87aa() {
  if(isPlayer(self)) {
    self stoprenderoverridebundle("rob_ammo_mod_level_1");
    self stoprenderoverridebundle("rob_ammo_mod_level_2");
    self stoprenderoverridebundle("rob_ammo_mod_level_3");
    self stoprenderoverridebundle("rob_ammo_mod_level_4");
    self stoprenderoverridebundle("rob_ammo_mod_level_5");
  }
}

function function_c059fde4(localclientnum, fx) {
  self util::waittill_dobj(localclientnum);

  if(isPlayer(self) && self hasdobj(localclientnum)) {
    self.var_8502e221 = playviewmodelfx(localclientnum, fx, "tag_fx1", 0);
  }
}

function function_cc40e7e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_ac9a87aa();

  if(bwastimejump > 1) {
    self playrenderoverridebundle(function_74b823de(bwastimejump));
  }
}

function function_c62bfdf2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self endon(#"death");
    waitframe(1);

    if(isDefined(self.var_8502e221)) {
      killfx(fieldname, self.var_8502e221);
    }

    self function_c059fde4(fieldname, "zm_weapons/fx9_aat_cryofreeze_attachment_amb_1p");
    return;
  }

  if(isDefined(self.var_8502e221)) {
    killfx(fieldname, self.var_8502e221);
  }

  self function_ac9a87aa();
}

function function_f745370f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self endon(#"death");
    waitframe(1);

    if(isDefined(self.var_8502e221)) {
      killfx(fieldname, self.var_8502e221);
    }

    self function_c059fde4(fieldname, "zm_weapons/fx9_aat_burnination_attachment_amb_1p");
    return;
  }

  if(isDefined(self.var_8502e221)) {
    killfx(fieldname, self.var_8502e221);
  }

  self function_ac9a87aa();
}

function function_7c325bd9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self endon(#"death");
    waitframe(1);

    if(isDefined(self.var_8502e221)) {
      killfx(fieldname, self.var_8502e221);
    }

    self function_c059fde4(fieldname, "zm_weapons/fx9_aat_brain_rot_attachment_amb_1p");
    return;
  }

  if(isDefined(self.var_8502e221)) {
    killfx(fieldname, self.var_8502e221);
  }

  self function_ac9a87aa();
}

function function_5cc517e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self endon(#"death");
    waitframe(1);

    if(isDefined(self.var_8502e221)) {
      killfx(fieldname, self.var_8502e221);
    }

    self function_c059fde4(fieldname, "zm_weapons/fx9_aat_dead_wire_attachment_amb_1p");
    return;
  }

  if(isDefined(self.var_8502e221)) {
    killfx(fieldname, self.var_8502e221);
  }

  self function_ac9a87aa();
}

function function_6ab142a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self endon(#"death");
    waitframe(1);

    if(isDefined(self.var_8502e221)) {
      killfx(fieldname, self.var_8502e221);
    }

    self function_c059fde4(fieldname, "zm_weapons/fx9_aat_shatterblast_attachment_amb_1p");
    return;
  }

  if(isDefined(self.var_8502e221)) {
    killfx(fieldname, self.var_8502e221);
  }

  self function_ac9a87aa();
}