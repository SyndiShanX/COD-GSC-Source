/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitypes\aitype.gsc
**************************************/

#using scripts\aitypes\assets;
#using scripts\common\ai_settings;
#namespace aitype;

function main(aitype, aitypescriptbundle, selectedcharacter, weaponstruct) {
  self.aitypeid = function_31cdbcf8e68aa5a5(#"aitype", getxhashasset(aitype));

  if(aitypescriptbundle.subclass != "") {
    self.subclass_scriptbundle = getscriptbundle(hashcat(%"hash_138dab78b1b28a0f", aitypescriptbundle.subclass));
    self.subclass = self.subclass_scriptbundle.name;
  }

  if(aitypescriptbundle.healthbarsettings != "") {
    self.healthbarsettingsid = function_31cdbcf8e68aa5a5(#"scriptbundle_healthbarsettings", getxhashasset(aitypescriptbundle.healthbarsettings));
    healthbarbundle = getscriptbundle(hashcat(%"hash_4d444a8663c91c96", aitypescriptbundle.healthbarsettings));

    if(isDefined(healthbarbundle)) {
      if(istrue(healthbarbundle.supporthealthbar)) {
        self.var_ac7fb140818d03b3 = 1;
      }

      if(istrue(healthbarbundle.supportnameplate)) {
        self.var_cd5810495789bb61 = 1;
      }

      if(!healthbarbundle.hidedisplayname && healthbarbundle.randomdisplayname && healthbarbundle.displaynamelist.size > 0) {
        self.nameindex = randomintrange(0, healthbarbundle.displaynamelist.size);
      }
    }
  }

  self.behaviortreeasset = getxhashasset(aitypescriptbundle.behaviortreeasset);
  self.aishootstyle = aitypescriptbundle.var_7038de8e5cf5e101;
  self.asmasset = aitypescriptbundle.animationstatemachine;

  if(aitypescriptbundle.var_6aac260aa7029f75 != "") {
    self.ai_eventlist = aitypescriptbundle.var_6aac260aa7029f75;
  }

  if(aitypescriptbundle.zombieaisetting != "") {
    self.zombieaisetting = aitypescriptbundle.zombieaisetting;
  }

  if(aitypescriptbundle.aisettingsbundle != "") {
    ai_settings::function_8220aac0ff835653(aitypescriptbundle.aisettingsbundle);
  }

  assign_weapons(aitypescriptbundle, weaponstruct);

  if(istrue(aitypescriptbundle.var_b65b56245fb71fbc)) {
    self.var_b65b56245fb71fbc = 1;

    if(isDefined(aitypescriptbundle.var_ecdf7ff158ce47bf) && isDefined(aitypescriptbundle.var_6e8b1256c89629a6)) {
      self.var_ecdf7ff158ce47bf = aitypescriptbundle.var_ecdf7ff158ce47bf;
      self.var_6e8b1256c89629a6 = aitypescriptbundle.var_6e8b1256c89629a6;
    }
  }

  assert(isDefined(selectedcharacter) && isDefined(level.fncharacter[selectedcharacter]), "<dev string:x24>" + (isDefined(selectedcharacter) ? getxhashsourcename(selectedcharacter) : "<dev string:x79>") + "<dev string:x86>");
  [[level.fncharacter[selectedcharacter]]]();
}

function assign_weapons(aitypescriptbundle, weaponstruct) {
  if(isDefined(aitypescriptbundle.grenadeweapon) && aitypescriptbundle.grenadeweapon != "") {
    self.grenadeweapon = level.var_3bf930d80da53917[getxhash(aitypescriptbundle.grenadeweapon)];
    self.grenadeammo = aitypescriptbundle.grenadeammo;
  } else {
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
  }

  if(isDefined(weaponstruct.primaryweaponhash)) {
    self.weapon = level.var_3bf930d80da53917[weaponstruct.primaryweaponhash];
  } else {
    self.weapon = nullweapon();
  }

  if(isDefined(weaponstruct.secondaryweaponhash)) {
    self.secondaryweapon = level.var_3bf930d80da53917[weaponstruct.secondaryweaponhash];
  } else {
    self.secondaryweapon = nullweapon();
  }

  if(isDefined(weaponstruct.sidearmweaponhash)) {
    self.sidearm = level.var_3bf930d80da53917[weaponstruct.sidearmweaponhash];
    return;
  }

  self.sidearm = nullweapon();
}

function precache(aitype, aitypescriptbundle, weaponstruct) {
  foreach(charactertype in aitypescriptbundle.charactertypes) {
    if(charactertype.character == "") {
      continue;
    }

    assert(isDefined(level.fncharacterprecache[getxhashasset(charactertype.character)]), "<dev string:x8c>" + charactertype.character + "<dev string:x86>");
    [[level.fncharacterprecache[getxhashasset(charactertype.character)]]]();
  }

  foreach(characterlist in aitypescriptbundle.characterlists) {
    if(characterlist.characterlistname == "" || !isDefined(characterlist.charactertypes)) {
      continue;
    }

    foreach(charactertype in characterlist.charactertypes) {
      if(charactertype.character == "") {
        continue;
      }

      assert(isDefined(level.fncharacterprecache[getxhashasset(charactertype.character)]), "<dev string:x8c>" + charactertype.character + "<dev string:x86>");
      [[level.fncharacterprecache[getxhashasset(charactertype.character)]]]();
    }
  }

  assets::setup_asset(aitypescriptbundle.unittype);
  thread setup_weapons(weaponstruct, aitypescriptbundle, aitype);
}

function validate_weapon(aitype, rootname, attachments, camo, reticle, variantid) {
  if(![[level.aivalidateweapon]](rootname, attachments, camo, reticle, variantid)) {
    assertmsg("<dev string:xe3>" + aitype + "<dev string:xef>" + rootname);
    return false;
  }

  return true;
}

function setup_weapons(weaponstruct, aitypescriptbundle, aitype) {
  if(aitypescriptbundle.validmode != "Y\xc1") {
    while(!(isDefined(level.weaponmapdata) && isDefined(level.aibuildweapon))) {
      waitframe();
    }
  }

  if(!isDefined(level.var_3bf930d80da53917)) {
    level.var_3bf930d80da53917 = [];
  }

  foreach(weapon in weaponstruct.weaponlist) {
    if(!isDefined(level.var_3bf930d80da53917[weapon.weaponhash])) {
      if(isDefined(weapon.attachments)) {
        attachments = weapon.attachments;
      } else if(aitypescriptbundle.validmode == "Y\xc1") {
        attachments = [];
      } else {
        attachments = ["\r+x5", "\r+x5", "\r+x5", "\r+x5", "\r+x5", "\r+x5"];
      }

      if(aitypescriptbundle.validmode == "Y\xc1") {
        level.var_3bf930d80da53917[weapon.weaponhash] = makeweapon(weapon.weaponname, attachments);
        continue;
      }

      if(validate_weapon(aitype, weapon.weaponname, attachments, "!w\t\xea\x0fr+\x96&", "\r+x5")) {
        level.var_3bf930d80da53917[weapon.weaponhash] = [[level.aibuildweapon]](weapon.weaponname, attachments, "!w\t\xea\x0fr+\x96&", "\r+x5");
      }
    }
  }

  if(isDefined(aitypescriptbundle.grenadeweapon)) {
    grenadeweaponhash = getxhash(aitypescriptbundle.grenadeweapon);

    if(!isDefined(level.var_3bf930d80da53917[grenadeweaponhash])) {
      defaultattachments = aitypescriptbundle.grenadeweapon == "" ? undefined : getweapondefaultattachments(aitypescriptbundle.grenadeweapon);
      level.var_3bf930d80da53917[grenadeweaponhash] = makeweapon(aitypescriptbundle.grenadeweapon, defaultattachments);
    }
  }
}