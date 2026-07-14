/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_178d5ed9c26037d0.gsc
*****************************************************/

#using scripts\common\weapon;
#namespace namespace_285f2d8d2827221c;

function get_default_weapon(isprimary) {
  gamemodebundle = getgamemodescriptbundle();

  if(isDefined(gamemodebundle) && isDefined(gamemodebundle.weaponlist)) {
    weaponlistbundle = getscriptbundle(gamemodebundle.weaponlist);

    if(isprimary) {
      return weaponlistbundle.defaultprimaryweapon;
    }

    return weaponlistbundle.defaultsecondaryweapon;
  }
}

function update_player_weapon() {
  if(isDefined(self.primaryweaponobj)) {
    self takeweapon(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none") {
    self takeweapon(self.secondaryweaponobj);
  }

  self.primaryweaponobj = undefined;
  self.secondaryweaponobj = undefined;
  loadoutdata = self function_cb8df376b3e57420();
  self.primaryweaponobj = loadoutdata.primaryweaponentityindex;

  if(!isDefined(self.primaryweaponobj) || self.primaryweaponobj.basename == "none") {
    primaryweapon = get_default_weapon(1);
    self.primaryweaponobj = weapon::buildweapon(primaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, []);
  }

  self giveweapon(self.primaryweaponobj);
  self setweaponammoclip(self.primaryweaponobj, weaponclipsize(self.primaryweaponobj));
  self setweaponammostock(self.primaryweaponobj, weaponmaxammo(self.primaryweaponobj));
  self setactionslot(3, "altmode");
  self.secondaryweaponobj = loadoutdata.secondaryweaponentityindex;

  if(!isDefined(self.secondaryweaponobj) || self.secondaryweaponobj.basename == "none") {
    secondaryweapon = get_default_weapon();
    self.secondaryweaponobj = weapon::buildweapon(secondaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, []);
  }

  self giveweapon(self.secondaryweaponobj);
  self setweaponammoclip(self.secondaryweaponobj, weaponclipsize(self.secondaryweaponobj));
  self setweaponammostock(self.secondaryweaponobj, weaponmaxammo(self.secondaryweaponobj));
  self switchtoweaponimmediate(self.primaryweaponobj);
}