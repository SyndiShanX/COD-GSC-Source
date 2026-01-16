/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ai_subclass\_subclass_dualwield.gsc
****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\ai_subclass\anims_table_dualwield;
#include animscripts\shared;

subclass_dualwield() {
  if(self.type != "human") {
    return;
  }
  self.a.fakepistolweaponanims = 1;

  if(weaponanims() != "pistol") {
    assertmsg(self.weapon + " is not supported for dualwielding AI type.");

    return;
  }

  self.maxfaceenemydist = 256;
  self.noheatanims = 1;
  self allowedstances("stand");
  self.a.runonlyreact = 1;
  self.a.disablelongdeath = 1;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.grenadeammo = 0;
  self.a.disablereacquire = 1;
  self.dontmelee = 1;
  self.a.allow_sidearm = 0;
  self.a.dontswitchtoprimarybeforemoving = 1;
  self.combatmode = "exposed_nodes_only";
  self.usecombatscriptatcover = 1;
  self.a.disablewoundedset = 1;
  self.pathenemyfightdist = 64;
  self.leftgunmodel = spawn("script_model", self.origin);
  self.leftgunmodel setmodel(self.weaponmodel);
  self.leftgunmodel useweaponhidetags(self.weapon);
  self.leftgunmodel linkto(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));

  recordent(self.leftgunmodel);

  self.rightgunmodel = spawn("script_model", self.origin);
  self.rightgunmodel setmodel(self.weaponmodel);
  self.rightgunmodel useweaponhidetags(self.weapon);
  self.rightgunmodel linkto(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));

  recordent(self.rightgunmodel);

  self.rightgunmodel hide();
  self.secondgunhand = "left";
  self thread dualweapondroplogic();
  self thread fakedualwieldshooting();
  self thread deletefakeweaponsondeath();
  setup_dualwield_anim_array();
}

fakedualwieldshooting() {
  self endon("death");

  while(true) {
    self waittill("shoot");

    if(self.secondgunhand == "left") {
      self animscripts\shared::placeweaponon(self.weapon, "left");
      self.leftgunmodel hide();
      self.rightgunmodel show();
      self.secondgunhand = "right";
    } else {
      self animscripts\shared::placeweaponon(self.weapon, "right");
      self.leftgunmodel show();
      self.rightgunmodel hide();
      self.secondgunhand = "left";
    }
  }
}

deletefakeweaponsondeath() {
  self waittill("death");
  self.leftgunmodel delete();
  self.rightgunmodel delete();
}

dualweapondroplogic() {
  dualweaponname = "";

  switch (self.weapon) {
    case "makarov_sp":
      dualweaponname = "makarovdw_sp";
      break;
    case "cz75_sp":
      dualweaponname = "cz75dw_sp";
      break;
    case "cz75_auto_sp":
      dualweaponname = "cz75dw_auto_sp";
      break;
    case "python_sp":
      dualweaponname = "pythondw_sp";
      break;
    case "m1911_sp":
      dualweaponname = "m1911dw_sp";
      break;
  }

  if(isassetloaded("weapon", dualweaponname))
    self.script_dropweapon = dualweaponname;
}