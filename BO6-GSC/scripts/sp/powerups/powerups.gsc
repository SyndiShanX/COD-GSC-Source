/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\powerups\powerups.gsc
********************************************/

#using scripts\common\powerups;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace powerups;

function private autoexec init() {
  root = function_af35457112dfa81b();
  init_powerups("e\x14\x16\xc5\xc8", &function_5ec01b26e8edc110);
  root.var_9469aa34714c6d4d = &function_3822d2d69917f532;
  root.var_d0b968b0e9da1f7f = &function_96e82532fbcbc17e;
  root.var_e50dfb8742e5ba52 = &function_685e921c7f3de6a1;

  foreach(powerupinfo in root.powerups) {
    if(isDefined(powerupinfo.image) && powerupinfo.image != "") {
      precacheshader(powerupinfo.image);
    }
  }
}

function function_5ec01b26e8edc110() {
  register_powerup("@\xc7[:\xf1\xbd!\xd5\x02<*#\xf3\xd8*s\xf6", &function_fe7196562ea16ba4);
  register_powerup("\x85\x1a\xd3\x853\"\x06&`B\x97\xfe\x84_\xac|\xe2", &function_fe7196562ea16ba4);
  register_powerup("\x0e\xed\xbb\xca\x9c\xae\xe0\xf5li\x9d\rtw+\xb4\x9d\r:", &function_fe7196562ea16ba4);
}

function function_fe7196562ea16ba4(str_powerup, ent_powerup) {
  player = self;
  player notify(str_powerup);
  player endon(str_powerup);
  function_fc894bdbb5b9ec4(str_powerup);
}

function private function_fc894bdbb5b9ec4(str_powerup) {
  player = self;
  assert(isPlayer(player));
  root = function_af35457112dfa81b();
  player function_e2011903ed5cfdd5(str_powerup);
  player powerup_hud_show(str_powerup, root.powerups[str_powerup].var_f6cc79403ff4d4f);
}

function private function_3822d2d69917f532(hud_powerup, n_lifetime = 2, var_36ba325c699f3ec1, var_973d2947cc31853b) {
  n_lifetime = int(n_lifetime);
  notifystring = "2C=_:" + hud_powerup.str_powerup;
  self notify(notifystring);
  function_80a188415c0433ff(hud_powerup, n_lifetime);
  wait n_lifetime;
  utility::delaythreadendon(0.2, notifystring, &function_80a188415c0433ff, hud_powerup, 0);
}

function private function_96e82532fbcbc17e(str_powerup) {
  waitframe();
  refname = "\xd0]F\xf5\xc1\xb7w\xca'u\xc1_" + str_powerup;

  if(istrue(hud_management::function_48c98ea9a4f0da89(refname))) {
    hud_management::scripted_widget_destroy(refname);
  }

  self notify("R\x94R\xc8\x9d\xa8\x89v}\x18\rC\xac\x95/\b\xe3 \xc0\x86" + str_powerup);
}

function private function_685e921c7f3de6a1() {
  return true;
}