/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\t10_c4.gsc
*******************************************/

#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\sp\equipment\c4;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#namespace t10_c4;

function private autoexec __init__system__() {
  system::register(#"t10_c4_sp", [#"val"], &pre_main, undefined);
}

function private pre_main() {
  offhands::registerprecachefunc("\xa3\\\xe9\xdb\xd8E\xe6\xf5\x7f", &precache);
}

function private precache(offhand) {
  precachemodel("\xa9\xd5\xda\\Du:8\x19\xe17\xae\x88\xe8P[\xf8");
  c4::precache(offhand);
  offhands::overrideweaponoffhandtype(offhand, 1);
  level.var_7d786abdb400836c = &c4_watchfordetonation;
  level.var_de5d12b418601955 = 0.1;
  val::register("\xb4RO\xa4\x81\xeed|\xc1c\x95\xe1t'\x7f", 1, 1);
}

function private function_6a4353fa381e383b(newent) {
  self notify("\xd8G\xb0\x1cZ\xa6,\x17v3\x0e\xaas@G>");
  self endon("\xd8G\xb0\x1cZ\xa6,\x17v3\x0e\xaas@G>");

  if(!isplatformps4()) {
    return;
  }

  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(isent(newent)) {
    newentnum = newent getentitynumber();
    self.var_c612212228d18a48[newentnum] = newent;
  }

  while(isarray(self.var_c612212228d18a48) && self.var_c612212228d18a48.size > 0) {
    waittillframeend();

    if(!istrue(self.player_prestream_assets_thread["\xff\xb2\x0e\xc5\xc8"])) {
      self.var_c612212228d18a48 = utility::array_removeundefined(self.var_c612212228d18a48, 1);
      currentuseent = self getplayeruseentity();

      if(isent(currentuseent)) {
        foreach(useent in self.var_c612212228d18a48) {
          if(useent == currentuseent) {
            utility::function_c47b5325ebd03f27("\xff\xb2\x0e\xc5\xc8", "\xa9\xd5\xda\\Du:8\x19\xe17\xae\x88\xe8P[\xf8", 5);
            break;
          }
        }
      }
    }

    waitframe();
  }

  self.var_c612212228d18a48 = undefined;
}

function c4_watchfordetonation(grenade) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  grenade.ignoreattackers = 1;
  displaydist = level.var_e68f7a340661d651 ?? 2000;
  usedist = level.var_d4f7996ae30d13bc ?? 2000;

  while(true) {
    detonatehintent = grenade utility::function_94c66bbed3da2a18();
    detonatehintent linkTo(grenade);
    detonatehintent cursor_hint::create_cursor_hint(undefined, offhands::function_ae7e42c967ccbe54(grenade.basename), &"hash_345f638996ef47c8", 55, displaydist, usedist, 1, undefined, undefined, "WZ\xbe\xd0\xd52\xfa\xe6\a\xeb-6\xbd\xe6}\x95\xb8\xab-\x1c[\xb2\xcd\x8e\xd7\xd8\x1a", "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96");
    detonatehintent childthread function_dc58d236581e8b56(self);
    thread function_6a4353fa381e383b(detonatehintent.cursor_hint_ent);

    while(true) {
      msg = detonatehintent utility::waittill_any_ents_return(detonatehintent, "\x91`\xb1\xe7T\x97>", grenade, "\x1e\xfd\xd1\xa2\a");

      if(msg == "\x1e\xfd\xd1\xa2\a" && isent(grenade)) {
        continue;
      }

      break;
    }

    detonatehintent cursor_hint::remove_cursor_hint();
    detonatehintent delete();

    if(val::get("\xb4RO\xa4\x81\xeed|\xc1c\x95\xe1t'\x7f")) {
      if(msg == "\x91`\xb1\xe7T\x97>") {
        self giveandfireoffhand(")\xab\xf8'\x02\xc2\x94\x91tvmwk\xf2\\");
        wait 0.68;
        grenade thread c4::c4_detonate();
        self notify("#\xacG\xb7\xcd\vt\xac");
      }

      break;
    }

    if(msg == "\x91`\xb1\xe7T\x97>") {
      wait 0.1;
      continue;
    }

    break;
  }
}

function private function_dc58d236581e8b56(owner) {
  self notify("\xb1\xc0\r\xd01f\xcc3b\x1ba\a2C\x18\x18");
  self endon("\xb1\xc0\r\xd01f\xcc3b\x1ba\a2C\x18\x18");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x91`\xb1\xe7T\x97>");
  self endon("\x1e\xfd\xd1\xa2\a");
  ishidden = undefined;

  while(true) {
    dist = distance(owner getEye(), self.origin);

    if(!owner val::get("\xb4RO\xa4\x81\xeed|\xc1c\x95\xe1t'\x7f")) {
      if(!istrue(ishidden)) {
        ishidden = 1;
        self.cursor_hint_ent hide();
      }
    } else if(dist > 130 && istrue(ishidden)) {
      ishidden = undefined;
      self.cursor_hint_ent show();
    } else if(dist <= 130 && !istrue(ishidden)) {
      ishidden = 1;
      self.cursor_hint_ent hide();
    }

    waitframe();
  }
}