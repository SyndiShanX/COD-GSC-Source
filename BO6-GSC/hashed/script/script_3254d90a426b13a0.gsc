/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3254d90a426b13a0.gsc
*****************************************************/

#using scripts\common\ui;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace namespace_744fa97fe424d22c;

function function_327d62fc830b430f() {
  funcarray = [];
  funcarray["-7\xa5\xa3"] = &visibilitymode_init;
  funcarray["\xc2\t:\x19\x02\xd0*Y\x1a"] = &visibilitymode_shouldrun;
  funcarray["\xd6\xcd\x1f5\x87v1\xfb\x99\xc9\xc6\x8d\x03\x19\x1d"] = &visibilitymode_enable;
  funcarray["\xf5!\x81\xa3\x97E\x8d"] = &visibilitymode_disable;
  funcarray["W\xf3\x9b\xdb\xc4\xaaT\x87x.\xe2*\xb3G\xd6\xe0\xd7\xdcI"] = &function_5a85e34b8f6f8d47;
  funcarray["\xf0\xfe\x86?q\xe3\x94\x81X-mn\xf5"] = &function_d297b8e7e8289e0c;
  funcarray["Z\x87\x81\xdc\x84L?\r{\\\"\x19\xd2\xa1\xdb\xf8"] = &function_c4f49f18895b2aa0;
  funcarray["\xdf]\xd9B.\xad\xba9\x03\x90;+\r "] = &visibilitymode_gettargetarray;
  funcarray["\xf6\xe0\xd1\xb4\xb7\xe6\x16\x8dP\x88\x9a\xc8\xd5\xe6\xc6\xdc"] = &function_f5a9010996bd248e;
  funcarray["\xaa\xe8\x9a$Q\x7ffr\xd3\x9c\xd9\xb0\xf60\xd24\xf8Bo\xb2"] = &function_9b21af0ee70b5d66;
  funcarray["\xe7\x9d\xce\xefL,aC\xb59\xb1\xa9"] = &function_e369902ec23166f;
  funcarray["\x8aaj\xf7\x16TF\x1a\x03I\x17]xL\x80a"] = &function_8e4cef3c7b6778f2;
  funcarray["\xfe\x05\x93\xa4#kN\xb1\x92\xc6\r:\xf0\r\xc3"] = &function_f50fe18e338f8cdc;
  funcarray["\x11\xaf\x97\xae\xc4aM\xd4\\\xbd\x84\xf29\xda\xf3\f]"] = &function_245900b91385e720;
  return funcarray;
}

function visibilitymode_init() {
  utility::flag_wait("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");
  utility_sp::hudoutline_add_channel("\xa1\xd2\xd9h\xd0\xdenG\xe4Xs\xa3\x9a\xbd2e", -10);
}

function visibilitymode_shouldrun() {
  return true;
}

function function_1fd7f901b4920617() {
  while(!isDefined(level.player.values) || level.player val::get(" \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[")) {
    wait 0.1;
  }
}

function visibilitymode_enable(client, assetname, prioritygroup) {
  soldiernum = self getentitynumber();
  self.var_19f4eb185e5d26fd = prioritygroup;
  utility_sp::hudoutline_enable_new(assetname, "\xa1\xd2\xd9h\xd0\xdenG\xe4Xs\xa3\x9a\xbd2e");
  return soldiernum;
}

function visibilitymode_disable(id) {
  utility_sp::hudoutline_disable("\xa1\xd2\xd9h\xd0\xdenG\xe4Xs\xa3\x9a\xbd2e");
}

function function_c4f49f18895b2aa0() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "\xff\x12\x9a\xbe.a") {
    return 5500;
  }

  return 1500;
}

function visibilitymode_gettargetarray(client) {
  aiarray = getaiarray();
  fakearray = getfakeaiarray();
  drones = [];
  allmodels = getEntArray("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #code_classname);

  for(i = 0; i < allmodels.size; i++) {
    if(isDefined(allmodels[i].team) && isDefined(allmodels[i].type) && allmodels[i].type == "\x1aW\xb6\xc2\xe6") {
      drones[drones.size] = allmodels[i];
    }
  }

  all = utility::array_combine(aiarray, fakearray, drones);
  return all;
}

function function_245900b91385e720(value) {
  if(!isDefined(level.player.visibilitymode)) {
    level.player.visibilitymode = spawnStruct();
  }

  level.player.visibilitymode.enablevalue = level.player getlocalplayerprofiledata("\xf8\x06sfg!\xd07\xf1\xcf\xabA\xef\xf8e\xc5\xfc\a\x03^\xef\xe9Y\x1aa");
  level.player.visibilitymode.outlinevalue = level.player getlocalplayerprofiledata("\xc9\xc0\x86\x8eHW\x87cu\xb3\\6\xd6\x8a\x84\xc7\xd1\xdc\xc6\x94\x14_\xf3m{\xbf[<,");
  level.player.visibilitymode.allytypevalue = level.player getlocalplayerprofiledata("\v\x88V\x88N\xb5\x90\xc7wyP\xa6\xb4\xf3\xc4\n\xc3\x91\xd7\xa2\x1d$!\xb2");
  level.player.visibilitymode.enemytypevalue = level.player getlocalplayerprofiledata("\x8c<U\x81\xb9{x\x14\x02m!\xcd9op\x82T<\x14-\xd7s,\x8f\xa1");
  level.player.visibilitymode.neutraltypevalue = level.player getlocalplayerprofiledata("\xa8\x04\xe4c\xd629v\xc6\xbb6\xc9\x7f\x9f\xcd\xb8h\aAn\xd5vy\xf4& 9");
  level.player.visibilitymode.contestedtypevalue = level.player getlocalplayerprofiledata("\x19\x16B\x9c\x8e\xa5A\xd0h\xa7\rZ#\x03\xdc\xa4\x85\x15O\x91\xfc\r#\xb6\xde\xe1\xcf");
  level.player.visibilitymode.interactabletypevalue = level.player getlocalplayerprofiledata("\xf0\x85>\x1c\xa8$\xa3\x1a\xba\x0eS\x180\xd4\x1b\xde\x8bWK\x01\xbeA\xee\x96\xd9k\x16\xb7\x86\xa6\x9a");
  level.player.visibilitymode.darkbackgroundvalue = level.player getlocalplayerprofiledata("uyW\x19\xdc8%j\xa8Q\xce\x18\xf6\x02\xbd\xd0\x0fCG\xa4\x8b\xc7\xb4\xcf2\xe0\x7f\\SrgT");
  level.player visibility_mode::visibilitymode_unpackvalue();

  if(level.player.visibilitymode.enablevalue == 0) {
    utility_sp::hudoutline_activate_best_channel();
  }
}

function function_5a85e34b8f6f8d47() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    wait 1;

    if(!isDefined(level.player)) {
      continue;
    }

    function_245900b91385e720();
    break;
  }

  ui::lui_registercallback("\x9c\x94>\x1b\xfd\x89.NB\xffX\xaa\xd4\xda\x1b}\\o\xe4\x98%\x9a*\xc9}v\x9e", &function_245900b91385e720);
  level.player thread function_25a772c298cb57d6();
}

function function_f5a9010996bd248e() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self.visibilitymodeads = 0;
  self.var_6804b904d9b50669 = 0;
  self notifyonplayercommand("g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5", "\xa8\x94\xb5Ls\x10");
  self notifyonplayercommand("g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5", "\x18\xf77d\x8e\\\x1fjq\xbd(");
  self notifyonplayercommand("g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5", "\xa8\x9c\xca\x8a\xf8\xfa\xc5\xc2:\xf2M\x1d\x98");
  self notifyonplayercommand("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self notifyonplayercommand("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi", "\xa1\xae0\x8aJ4\xcf");
  self notifyonplayercommand("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi", "\x9cK\xa0pRY\xa6C$");
  self notifyonplayercommand("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self notifyonplayercommand("\xdaK\xf4w\x1fW\xd2\aO\x93Qn\xdc\xaf?:\x88\x8d", "\xc2&]\x85h<\x8f\x06\xd6j\xc5\xed\xdc");
  self notifyonplayercommand("\xdaK\xf4w\x1fW\xd2\aO\x93Qn\xdc\xaf?:\x88\x8d", "_\x05\xd7\xb5\xed\r\xdb'<\x98\xd0\x01\xbf");

  while(visibility_mode::function_ea713a2a27cf4487()) {
    wait 0.1;

    if(!isalive(self)) {
      continue;
    }

    if(!visibility_mode::function_c24cba7a90f7a3c7()) {
      continue;
    }

    playerads = self playerads();

    if(playerads == 1) {
      if(self.visibilitymodeads == 0) {
        self.visibilitymodeads = 1;
        thread function_17ddccd6f5f5ec3d();
        thread function_2bcca0fe89fe19c5("g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5");
        thread function_2bcca0fe89fe19c5("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi");
        thread function_2bcca0fe89fe19c5("\xdaK\xf4w\x1fW\xd2\aO\x93Qn\xdc\xaf?:\x88\x8d");
      }

      continue;
    }

    if(playerads < 1) {
      self.visibilitymodeads = 0;
      self.var_6804b904d9b50669 = 0;
      self notify("\xce\xa57\x96bZ\xd8\x96ty\xd4\xedd\xac\xbes\xa3\xbd\x83X\x8c\xe6");
    }
  }
}

function private function_2bcca0fe89fe19c5(type) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xce\xa57\x96bZ\xd8\x96ty\xd4\xedd\xac\xbes\xa3\xbd\x83X\x8c\xe6");

  if(type == "g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5") {
    self waittill("g\xacpR\xa4\x0et}{\xb9\x1a]q|:t\xb5");
    childthread function_eb701d0c7415d00a();
    return;
  }

  if(type == "\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi") {
    self waittill("\xf9\x05[\xc4>o{\xdd\t7\x057\xb8\x7fi");
    childthread function_8e4cef3c7b6778f2();
    return;
  }

  if(type == "\xdaK\xf4w\x1fW\xd2\aO\x93Qn\xdc\xaf?:\x88\x8d") {
    self waittill("\xdaK\xf4w\x1fW\xd2\aO\x93Qn\xdc\xaf?:\x88\x8d");
  }
}

function private function_eb701d0c7415d00a() {
  clientallies = visibility_mode::function_781c23e790c3816();
  clientallies = sortbydistance(clientallies, self.origin);

  for(i = 0; i < clientallies.size; i++) {
    if(soundexists("G\x81V\x8f\xc5\x02\x1a\xde\xc5\xacm\xb7\xc8\x9eF\xc8)6j\xb2\xaf")) {
      clientallies[i] playSound("G\x81V\x8f\xc5\x02\x1a\xde\xc5\xacm\xb7\xc8\x9eF\xc8)6j\xb2\xaf");
      wait 0.1;
    }
  }
}

function private function_8e4cef3c7b6778f2() {
  if(getdvarint(@ "hash_e53d88b6cd6b6ffa", 0) > 0) {
    return;
  }

  wait 0.5;
  all_scriptables = getscriptablearray();

  if(isDefined(all_scriptables)) {
    all_scriptables = sortbydistancecullbyradius(all_scriptables, self.origin, 250);

    for(i = 0; i < all_scriptables.size; i++) {
      if(distancesquared(all_scriptables[i].origin, self.origin) > 62500) {
        continue;
      }

      if(all_scriptables[i] getscriptableisusableonanypart()) {
        if(all_scriptables[i] scriptableisdoor()) {
          if(all_scriptables[i] scriptabledoorisclosed()) {
            wait 0.25;

            if(soundexists("Vp\x1c\xa9.i5\xb0;\xdcw")) {
              all_scriptables[i] playSound("Vp\x1c\xa9.i5\xb0;\xdcw");
            }
          } else {
            wait 0.25;

            if(soundexists("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c")) {
              all_scriptables[i] playSound("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c");
            }
          }

          continue;
        }

        wait 0.25;

        if(soundexists("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c")) {
          all_scriptables[i] playSound("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c");
        }
      }
    }
  }

  var_96722c00a652a6e2 = getentarrayinradius("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #code_classname, self.origin, 250);

  if(isDefined(var_96722c00a652a6e2)) {
    var_96722c00a652a6e2 = sortbydistance(var_96722c00a652a6e2, self.origin);

    for(i = 0; i < var_96722c00a652a6e2.size; i++) {
      if(var_96722c00a652a6e2[i] isusable()) {
        wait 0.25;

        if(soundexists("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c")) {
          var_96722c00a652a6e2[i] playSound("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c");
        }
      }
    }
  }

  var_eac1c321c13c2eb5 = getentarrayinradius("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", #code_classname, self.origin, 250);

  if(isDefined(var_eac1c321c13c2eb5)) {
    var_eac1c321c13c2eb5 = sortbydistance(var_eac1c321c13c2eb5, self.origin);

    for(i = 0; i < var_eac1c321c13c2eb5.size; i++) {
      if(var_eac1c321c13c2eb5[i] isusable()) {
        wait 0.25;

        if(soundexists("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c")) {
          var_eac1c321c13c2eb5[i] playSound("\x885\x80]Hj#\x81\xc6_\x9a\x80W\xef\xbd\xf3\xf1c");
        }
      }
    }
  }

  wait 0.5;
  all_loot = getlootscriptablearrayinradius(undefined, undefined, self.origin, 250);

  if(isDefined(all_loot)) {
    all_loot = sortbydistance(all_loot, self.origin);

    for(i = 0; i < all_loot.size; i++) {
      wait 0.25;
      level thread function_f6e62c751485ed94(all_loot[i]);
    }
  }

  nearby_weapons = getweaponarrayinradius(self.origin, 250, 1);

  if(isDefined(nearby_weapons)) {
    nearby_weapons = sortbydistance(nearby_weapons, self.origin);

    for(i = 0; i < nearby_weapons.size; i++) {
      weaponpickupsound = nearby_weapons[i] function_29a94cddf437b231();
      wait 0.1;

      if(!isDefined(nearby_weapons[i])) {
        continue;
      }

      if(soundexists("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9")) {
        nearby_weapons[i] playSound("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9");
      }

      wait 0.1;

      if(!isDefined(nearby_weapons[i])) {
        continue;
      }

      if(soundexists(weaponpickupsound)) {
        nearby_weapons[i] playSound(weaponpickupsound);
      }

      if(distance2d(self.origin, nearby_weapons[i].origin) < 32) {
        for(i = 0; i < 3; i++) {
          wait 0.1;

          if(!isDefined(nearby_weapons[i])) {
            continue;
          }

          if(soundexists("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9")) {
            nearby_weapons[i] playSound("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9");
          }
        }
      }
    }
  }
}

function private function_f6e62c751485ed94(item) {
  if(!soundexists("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9")) {
    return;
  }

  tag_origin = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", item.origin);
  tag_origin setModel("\xec\xbfK|\au\xcd\xc2\x19<");
  tag_origin playSound("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9");
  wait lookupsoundlength("\x1c\xe4S\xebL\xab\x1bl\xb2\xe8_\xe6\xb6Xl6\xafp\x1b\xc9");
  tag_origin delete();
}

function function_29a94cddf437b231() {
  name = getweaponbasename(self);
  name_str = strtok(name, "w");

  for(i = 0; i < name_str.size; i++) {
    if(name_str[i] == "\xc2\xe4") {
      return "\xc3J=I1\xc4\xc6\x9bJX\xb3\xddzAgBd5";
    }

    if(name_str[i] == "\x0fW") {
      return "\xf7\xd8\x8a\xbeZe\xb3wg\x8bdZ\xfa\x9c\xa0\xc5\xf9\xd0";
    }

    if(name_str[i] == "\xe0\x12") {
      return ".\xb1\xde\xc7\xa7\xabM\f\x14\xa1 \xbc\xe6\x7f<4\xd5\xc7";
    }

    if(name_str[i] == "\x1a#\xbf") {
      return "\x18\xbd#\x0e\xb0\xf7=\xf9\xf1\xfc#\x01,\xa4\xc7\xe8\xe2\xa6\xbf";
    }

    if(name_str[i] == "\xff\x9el") {
      return "\x81\x9c}A%\xe00\x98\x99\xd1\xb8-\xd7{\x8c\x84\xa2$x";
    }

    if(name_str[i] == "@R") {
      return "\x81\xf1\xa5q\xd5\xa4(\x83\x87{\x90TI\xb40\x02\x8b\xdd\xd9\x99/\xbe";
    }

    if(name_str[i] == "\xe6\xd0") {
      return "\xa2\xa7\x93Br\xa87mo8\x883\x96\xd0\x15z\xbe\x93\xd2\x99?\xb0\xb7";
    }

    if(name_str[i] == "\xd8\xc2") {
      return "M\xe5\xeeC'+9\x90H\x17\xb1\xd7b^iOF\xf1\xa1\xab\x93\x94\xc1\xb3";
    }

    if(name_str[i] == "y'") {
      return "B\x98\xa6\x931\xd1\xe7Df\xe0\xc8\xa8\x7fma\xcc\xf7\x11b\xfd\\\xf7";
    }
  }

  return "\xddV,\xe0}\a-lk\xae\a";
}

function private function_17ddccd6f5f5ec3d() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xce\xa57\x96bZ\xd8\x96ty\xd4\xedd\xac\xbes\xa3\xbd\x83X\x8c\xe6");

  if(self.var_6804b904d9b50669 == 0) {
    self.var_6804b904d9b50669 = 1;
  } else {
    return;
  }

  maxdist = self[[level.visibilitymode.funcs["Z\x87\x81\xdc\x84L?\r{\\\"\x19\xd2\xa1\xdb\xf8"]]]();
  maxdistsq = squared(maxdist);
  clientenemies = visibility_mode::function_53e4fdb4bdc5153a();
  clientenemies = sortbydistance(clientenemies, self.origin);

  for(i = 0; i < clientenemies.size; i++) {
    if(clientenemies[i] lastknowntime(self) == 0) {
      continue;
    }

    if(distancesquared(clientenemies[i].origin, self.origin) < maxdistsq) {
      if(soundexists("\x02\x8e\x99n\xf3\xbf\xee\x1c~\xff\x10sR\xd4p\xc0\xc1")) {
        clientenemies[i] playSound("\x02\x8e\x99n\xf3\xbf\xee\x1c~\xff\x10sR\xd4p\xc0\xc1");
      }
    }
  }
}

function private function_9b21af0ee70b5d66(intoggle) {
  if(istrue(intoggle)) {
    pbgpostfxbundlestart(self, %"cer_vismode_nosaturation");
    val::set("N\x01\b\xd1\x8dvJ\xc2\xfa\xef\x99\xca;\xbd~\xa8y1\xeaG\xb72Q\a\xe0tr^", "\x16o\xbe\x16\xec~\xc89W\xc7P\x98E_g\x12:G5\x86\xdc", 1);
    val::set("N\x01\b\xd1\x8dvJ\xc2\xfa\xef\x99\xca;\xbd~\xa8y1\xeaG\xb72Q\a\xe0tr^", "+\xa8\x1d\xb65\x1f", 0);
    return;
  }

  pbgpostfxbundlekill(self, %"cer_vismode_nosaturation");
  val::reset_all("N\x01\b\xd1\x8dvJ\xc2\xfa\xef\x99\xca;\xbd~\xa8y1\xeaG\xb72Q\a\xe0tr^");
}

function function_f50fe18e338f8cdc() {
  if(issaverecentlyloaded()) {
    return true;
  }

  return false;
}

function function_e369902ec23166f() {
  if(self adsButtonPressed()) {
    return true;
  }

  return false;
}

function function_d297b8e7e8289e0c() {
  return 0.25;
}

function private function_25a772c298cb57d6() {
  self notify("\xccVLn\xc43\x86\xe69'& 1\xd8+\xb0\xc4");
  self endon("\xccVLn\xc43\x86\xe69'& 1\xd8+\xb0\xc4");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(isDefined(level.visibilitymode.funcs["\xfe\x05\x93\xa4#kN\xb1\x92\xc6\r:\xf0\r\xc3"])) {
    while(true) {
      if(self[[level.visibilitymode.funcs["\xfe\x05\x93\xa4#kN\xb1\x92\xc6\r:\xf0\r\xc3"]]]()) {
        if(isDefined(level.visibilitymode.funcs["\x11\xaf\x97\xae\xc4aM\xd4\\\xbd\x84\xf29\xda\xf3\f]"])) {
          self[[level.visibilitymode.funcs["\x11\xaf\x97\xae\xc4aM\xd4\\\xbd\x84\xf29\xda\xf3\f]"]]]();
        }
      }

      wait 1;
    }
  }
}