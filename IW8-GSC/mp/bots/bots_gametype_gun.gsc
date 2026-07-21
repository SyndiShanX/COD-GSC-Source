/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_gun.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_gun();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_gun_think;
}

setup_bot_gun() {}

data_pickup_logic(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "_encstr_8BBA05185F8B99") {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
    var_3 = level.bot_weap_personality[var_2];
    var_4 = strtok(var_3, "_encstr_AA07038F10");
    var_5 = weaponclass(var_0);

    if(var_5 == "_encstr_8D940738966ED1DB8D")
      var_4 = ["_encstr_931904C66102", "_encstr_BD560C63E89DE9BFF81D7747ADC0"];

    if(var_4.size > 0) {
      var_6 = undefined;

      if(scripts\engine\utility::array_contains(var_4, var_1))
        var_6 = var_1;
      else
        var_6 = scripts\engine\utility::random(var_4);

      if(self.personality != var_6)
        scripts\mp\bots\bots_util::bot_set_personality(var_6);
    }
  }
}

bot_gun_think() {
  self notify("_encstr_AF0B0E79ED4CC18C13F3EFB1C3FA40D8");
  self endon("_encstr_AF0B0E79ED4CC18C13F3EFB1C3FA40D8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self botgetdifficultysetting("_encstr_BE23115C039EB8170C257B791D73AB87A0AF5F");

  if(var_0 < 0.25)
    self botsetdifficultysetting("_encstr_BE23115C039EB8170C257B791D73AB87A0AF5F", 0.25);

  self botsetdifficultysetting("_encstr_8A9B0E47C31DC01387FBDD88AF740362", 1);
  var_1 = "_encstr_B40101";
  var_2 = self.personality;
  wait 0.1;

  for(;;) {
    var_3 = self getcurrentweapon();

    if(var_3.basename != "_encstr_8BBA05185F8B99" && !scripts\mp\utility\weapon::iskillstreakweapon(var_3) && var_3.basename != var_1 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_3)) {
      var_1 = var_3.basename;

      if(self botgetdifficultysetting("_encstr_82711489D52B67451FF88AC190557A2740CF1C097512") && self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0)
        data_pickup_logic(var_3.basename, var_2);
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}