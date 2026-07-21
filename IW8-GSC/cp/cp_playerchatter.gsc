/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_playerchatter.gsc
***********************************************/

init_playerchatter() {
  if(isDefined(anim.player.battlechatter)) {
    return;
  }
  anim.player.battlechatter = spawnStruct();
  anim.player.battlechatter.chatqueue = [];
  anim.player.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_85CB07BDE04321538B"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_840709B34F76BBF8F072C7"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_8A66099C590B3647D2B79B"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_85E507408AF3D0F005"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_88720627AD68179B"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_88720627AD68179B"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_88720627AD68179B"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_BD34078D57B9A37BD6"].priority = 0.0;
  anim.player.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"] = spawnStruct();
  anim.player.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].expiretime = 0;
  anim.player.battlechatter.chatqueue["_encstr_830E086EE82B0B361D86"].priority = 0.0;
  anim.player.battlechatter.nextsaytime = gettime() + 50;
  anim.player.battlechatter.nextsaytimes["_encstr_85CB07BDE04321538B"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_8A66099C590B3647D2B79B"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_840709B34F76BBF8F072C7"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_85E507408AF3D0F005"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_88720627AD68179B"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_BD34078D57B9A37BD6"] = 0;
  anim.player.battlechatter.nextsaytimes["_encstr_830E086EE82B0B361D86"] = 0;
  anim.player.battlechatter.isspeaking = 0;
  anim.player.battlechatter.minpriority = 0.0;
  anim.player.battlechatter.countryid = "_encstr_B407036B35";
}

player_battlechatter_on_thread() {
  while(!isDefined(anim.chatinitialized))
    wait 0.5;

  if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
    anim.player.battlechatterallowed = 1;
    anim.player.battlechatter.isspeaking = 0;
    thread player_battlechatter_cooldown_control();
    anim.player thread playerthreadthreader();
  }
}

player_update_allowed_callouts() {
  if(!isDefined(anim.player.allowedcallouts)) {
    anim.player.allowedcallouts = [];
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_A11904E483B3");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8E2508591EE07BE6B246");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_82F309E237DB1B6B6367E9");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_B2BC08303A77613B2FA4");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_86A411B288082775C051A1AB39213E434861AA");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_962A100B96EBE816E4CE5947EBD863DBB1AD");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_83240CF857AF812BC3C763F89E7A");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8C631507D8165EB24EAFB1F69B1D588DA3FAD88DDEC6B6");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8F4914586BB9FA1BEB11850732D25303DFFF6328CF5B");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8FE6108308376FD79327C3C955989C6B6F60");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_B1610BB3D781C068F6DC603B42");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_A37B1403190F2BDD20467D06D8A0E333C89FFB87EFA2");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_9A7C100ED80B5E56E47D63DB1BC23AB47BCD");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8F100C0BD2D763EDB116D15ABD9B");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_9A0E11705DF51B9A64698799D0E6A1ABFB388D");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_B4731043E9A960C7BF3B49D0A1C70948FE73");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_A3731036F6731B168EAFD87BD816A3A5DECD");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_A3731036F6731B168EAFD87BD816A3A5DECD");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_8B3C1059F1C7C3CB83782CDF93CB39B2D39D");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_834E19FFA24A713DA2FF4372FDC85F93AF4E70CA1938D720BF1768");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_9B7F0C0BD2EB46D29B8EC2CD8DAC");
    anim.player scripts\cp\cp_battlechatter_ai::addallowedthreatcallout("_encstr_B6B7158596FAE8B09CCE2B1DEB1B8D7BB16DBED096B386");
  }
}

player_battlechatter_off_thread() {
  anim notify("_encstr_AF0C19BFE40FA25B0A69B0A0F3A311796F984F3554A70BE7B5E2A8");

  if(isDefined(anim.player) && isDefined(anim.player.battlechatterallowed))
    anim.player.battlechatterallowed = 0;

  if(isDefined(anim.player) && isDefined(anim.player.battlechatter.isspeaking))
    anim.player.battlechatter.isspeaking = 0;
}

playerthreadthreader() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AF0C19BFE40FA25B0A69B0A0F3A311796F984F3554A70BE7B5E2A8");
  var_0 = 0.5;
  wait(var_0);
  thread scripts\cp\cp_battlechatter_ai::aigrenadedangerwaiter();
  wait(var_0);
  thread playerdogfightwaiter();
  wait(var_0);
  thread playerdamagewaiter();
  wait(var_0);
  thread scripts\cp\cp_battlechatter_ai::aibattlechatterloop();
}

playerdamagewaiter() {
  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    anim.player waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(var_1 scripts\cp\cp_battlechatter::bcissniper()) {
      var_2 = anim.squads["_encstr_9A8507BA4040188D08"].members;
      var_2 = scripts\engine\utility::array_randomize(var_2);

      foreach(var_4 in var_2) {
        if(isalive(var_4) && isai(var_4) && distancesquared(anim.player.origin, var_4.origin) > 10000) {
          var_4 scripts\cp\cp_battlechatter_ai::addthreatevent("_encstr_A20C099FE504225E886B40", var_1, 0.9);
          break;
        }
      }
    }

    wait 1.0;
  }
}

playerdogfightwaiter() {
  while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled())
    wait 1.0;

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      if(isDefined(level.player.dogfighttarget)) {
        if(isDefined(level.player.dogfighttarget._blackboard) && isDefined(level.player.dogfighttarget._blackboard.isevading)) {
          if(level.player.dogfighttarget._blackboard.isevading) {
            wait(randomfloatrange(0.25, 0.5));

            if(isDefined(level.player.dogfighttarget))
              anim.player scripts\cp\cp_battlechatter_ai::addreactionevent("_encstr_B18F09518733412BAF1AA0", "_encstr_979608DF73C8E70B73A1", level.player.dogfighttarget, 0.9);
          } else {
            wait(randomfloatrange(0.5, 0.75));

            if(isDefined(level.player.dogfighttarget))
              anim.player scripts\cp\cp_battlechatter_ai::addthreatevent("_encstr_82F309E237DB1B6B6367E9", level.player.dogfighttarget);
          }
        }
      }
    }

    wait 1.0;

    while(!scripts\engine\utility::player_is_in_jackal() && isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled())
      wait 1.0;
  }
}

playervehiclewaiter() {
  var_0 = undefined;

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(!scripts\engine\utility::player_is_in_jackal()) {
      var_1 = scripts\cp\utility::getvehiclearray();

      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(isDefined(var_0) && var_0 == var_3) {
          continue;
        }
        if(issubstr(var_3.classname, "_encstr_AC6E09C8CB35119B5B693F")) {
          if(isDefined(var_3.script_team) && var_3.script_team != anim.player.team) {
            if(anim.player scripts\cp\cp_battlechatter::pointinfov(var_3.origin) && distancesquared(anim.player.origin, var_3.origin) < 4000000) {
              var_4 = anim.squads["_encstr_9A8507BA4040188D08"].members;
              var_4 = scripts\engine\utility::array_randomize(var_4);

              foreach(var_6 in var_4) {
                if(isalive(var_6) && isai(var_6) && distancesquared(anim.player.origin, var_6.origin) < 250000) {
                  var_6 scripts\cp\cp_battlechatter_ai::addinformevent("_encstr_8A4F099025A3B8715A6B17", "_encstr_AC6E09C8CB35119B5B693F", 0.9, "_encstr_9A50080BA7292FFA0DA2");
                  var_0 = var_3;
                }
              }

              wait(randomintrange(15, 25));
            }
          }
        }
      }
    }

    wait 2;

    while(scripts\engine\utility::player_is_in_jackal())
      wait 5.0;
  }
}

player_battlechatter_cooldown_control() {
  anim.player.bcscooldown = 1;

  while(isalive(anim.player) && scripts\cp\cp_battlechatter::bcsenabled() && (isDefined(anim.player.battlechatterallowed) && anim.player.battlechatterallowed)) {
    if(anim.player.bcscooldown == 0)
      var_0 = 10;
    else
      var_0 = anim.player.bcscooldown;

    anim.player.battlechatter.isspeaking = 1;

    for(var_1 = var_0; var_1 >= 0; var_1--) {
      anim.player.bcscooldown = var_1;
      wait 1.0;
    }

    anim.player.battlechatter.isspeaking = 0;
    level waittill("_encstr_BEF31DDA6059D84528C7604683F013A1C2EB4231ABCFC03E8E2F9A30052B20");

    while(anim.player.battlechatter.isspeaking != 0)
      wait 0.5;
  }
}

player_battlechatter_generic_event_check() {
  anim.player endon("_encstr_AD75063D571AE108");
  level endon("_encstr_AF0C19BFE40FA25B0A69B0A0F3A311796F984F3554A70BE7B5E2A8");
  var_0 = "_encstr_8BBA05185F8B99";
  var_1 = ["_encstr_8EAF14ABB017FE173020F3FACFFBFF89B1080292B8E1", "_encstr_B60C155B8E0770E733CF91BF4B9AAD88EFA2E0B1347590", "_encstr_85ED1208BF81A3173783627A4E16379EA03D9564", "_encstr_812E0FC3168FD8EE0A5F0D038742B8605A", "_encstr_87A414DB1BF643E2E39FAAE971936B1C9EA84B37C04B"];

  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_1);

    if(var_2 != var_0 && var_2 != "_encstr_87A414DB1BF643E2E39FAAE971936B1C9EA84B37C04B") {
      anim.player scripts\cp\cp_battlechatter::playbattlechatter(var_2);
      var_0 = var_2;
      thread player_battlechatter_event_clear();
    } else if(var_2 == "_encstr_87A414DB1BF643E2E39FAAE971936B1C9EA84B37C04B")
      var_0 = "_encstr_8BBA05185F8B99";

    wait 1;
  }
}

player_battlechatter_event_clear() {
  wait 10;
  level notify("_encstr_87A414DB1BF643E2E39FAAE971936B1C9EA84B37C04B");
}

player_battlechatter_check_for_crate_pickups() {
  anim.player endon("_encstr_AD75063D571AE108");
  level endon("_encstr_AF0C19BFE40FA25B0A69B0A0F3A311796F984F3554A70BE7B5E2A8");

  for(;;) {
    var_0 = distance(anim.player.origin, self.origin);

    if(var_0 < 500) {
      if(scripts\cp\utility::player_looking_at(self.origin + (0, 0, 40))) {
        if(self.targetname == "_encstr_B2230CB06BB5DEAF1C2D36D6BA1C")
          level notify("_encstr_8EAF14ABB017FE173020F3FACFFBFF89B1080292B8E1");

        if(self.targetname == "_encstr_A27D119F7F235AA078F05B3B09F36122F79522")
          level notify("_encstr_B60C155B8E0770E733CF91BF4B9AAD88EFA2E0B1347590");

        if(self.targetname == "_encstr_8273114B801074F1D9BB8D0388D77B3AFB78A3")
          level notify("_encstr_812E0FC3168FD8EE0A5F0D038742B8605A");

        break;
      }
    }

    wait 1.0;
  }
}

isvalidplayerevent(var_0) {
  if(!isDefined(self.squad.ismembersaying[var_0]) || !isDefined(anim.isteamsaying[self.team][var_0]))
    return 1;

  if(!self.squad.ismembersaying[var_0] && !anim.isteamsaying[self.team][var_0])
    return 1;

  return 0;
}