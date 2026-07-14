/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\missilelauncher.gsc
******************************************/

#using scripts\common\missilelauncher;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace missilelauncher;

function initmissilelauncherusagesp() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xb2s\v\x85\xbc\xae\xd2\x8d*a\xfa\xc6\f\x18\xb4_\xe1\x8d\xa0\xb9\xe5\xa3x'\x84\xfa");
  self endon("\xb2s\v\x85\xbc\xae\xd2\x8d*a\xfa\xc6\f\x18\xb4_\xe1\x8d\xa0\xb9\xe5\xa3x'\x84\xfa");
  utility::registersharedfunc(#"missile_launcher", #"lockedon_missile_fired", &lockedonmissilefired);
  objweapon = self getcurrentweapon();

  while(true) {
    if(isDefined(objweapon) && (objweapon.basename == "%\x12V\x98\x8aV\xc3\xfd\xf8\xf5yH\xed8\xc0o\x0f\x80" || objweapon.basename == "c-\xa4y\xf8'4L6\xaeW\xcf2\xf2>\xb7qW9\x9d\xc2" || objweapon.basename == "\x12*\x0ff\xa8\"\xb0\xa8\x92\n\xd5\\?\xdd6\xbd\xb9\xbe\f\x04L\xd1\x81HH\xd9R")) {
      childthread initmissilelauncherusage();
      self notify("\xac\f\xe9\xe5\x89\x0ev.H\x12u\x05");
      childthread missilelauncherusageloop();
    }

    self waittill("Jz\xaf\x02A\xf5\xfcX\x96Z\x98YY", objweapon);
  }
}

function ismissilelauncherlockonallowed() {
  return utility::function_a28e1e0ca6b5a76d(self.var_2f01363f06fca079, 1);
}

function lockonlaunchergettargetarray(addcharacters) {
  targets = [];
  var_e6dcf7f592b648ee = getdvarint(@ "hash_10368af4dee3ba2c", 0);
  targetarray = getentarrayinradius(undefined, undefined, level.player.origin, 5000, 1);

  foreach(t in targetarray) {
    if(isent(t) && istrue(t.var_a2299a8dc6e2be60)) {
      targets[targets.size] = t;
      continue;
    }

    if(isDefined(t.team) && t.team == "?\xb1\xc0\x9a" || var_e6dcf7f592b648ee) {
      if(isalive(t) && (t vehicle::is_vehicle() || isDefined(t.classname) && t.classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e")) {
        targets[targets.size] = t;
      }
    }
  }

  return targets;
}

function private lockedonmissilefired(target) {
  if(isDefined(target)) {
    self notify("Sx\x98\xe05\xa7\xf8#\xb9p\xa0\xa7\xa9\xd4\xec\xe9\xe0\xecL6\x10\x01\xa8\xa1\x85", target);
  }
}