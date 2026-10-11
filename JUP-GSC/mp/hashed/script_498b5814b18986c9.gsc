/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_498b5814b18986c9.gsc
*************************************************/

#using scripts\common\swim_common;
#using scripts\cp_mp\gasmask;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#namespace namespace_119c80c54f2f80e1;

function init() {
  scripts\engine\utility::registersharedfunc("scubaGasMask", "hasScubaGasMask", &hasscubagasmask);
  scripts\engine\utility::registersharedfunc("scubaGasMask", "isScubaGasMaskEquipped", &isscubagasmaskequipped);
  scripts\engine\utility::registersharedfunc("scubaGasMask", "removeScubaGasMaskFromPlayer", &removescubagasmaskfromplayer);
  scripts\engine\utility::registersharedfunc("scubaGasMask", "updateScubaGasmask", &updatescubagasmask);
  scripts\engine\utility::registersharedfunc("scubaGasMask", "monitorScubaGasMaskDamage", &function_4e41bf5f9d46e115);
  scripts\engine\utility::registersharedfunc("scubaGasMask", "isUsingScubaGasMask", &isusingscubagasmask);
}

function private isusingscubagasmask(player) {
  return istrue(self.usingscubagasmask);
}

function hasscubagasmask(player) {
  return isusingscubagasmask(player) && scripts\cp_mp\gasmask::hasgasmask(player);
}

function isscubagasmaskequipped(player) {
  return hasscubagasmask(player) && scripts\cp_mp\gasmask::isgasmaskequipped(player);
}

function removescubagasmaskfromplayer(player) {
  if(hasscubagasmask(player)) {
    player.usingscubagasmask = undefined;
  }
}

function updatescubagasmask(player, isunderwater) {
  if(isDefined(player) && isDefined(player.origin)) {
    level thread function_9c13c9f95161d576(player, isunderwater);
  }
}

function function_9c13c9f95161d576(player, isunderwater) {
  player endon("death_or_disconnect");
  player notify("queue_scuba");
  player endon("queue_scuba");
  level endon("game_ended");

  while(true) {
    if(!istrue(player.gasmaskswapinprogress)) {
      break;
    }

    waitframe();
  }

  if(isunderwater) {
    player scripts\mp\gametypes\br_pickups::function_cdf7f2f6bd3207("underwater");
    return;
  }

  player scripts\mp\gametypes\br_pickups::function_8206bc54a1ed73cb("underwater");
}

function function_4e41bf5f9d46e115() {
  self endon("death_or_disconnect");
  self endon("swim_breathing_disabled_end");
  level endon("game_ended");
  var_9b7983c73df8b968 = getdvarfloat(@ "hash_4a852245a5077873", 1);
  var_76e563db5d11a0ea = getdvarfloat(@ "hash_8d16d3f760df5419", 0.857);

  while(true) {
    if(!scripts\common\swim_common::isplayerunderwater()) {
      break;
    }

    if(!hasscubagasmask(self)) {
      break;
    }

    if(isDefined(self.origin) && !istrue(self.plotarmor)) {
      scripts\cp_mp\gasmask::processdamage(var_76e563db5d11a0ea);
    }

    wait var_9b7983c73df8b968;
  }
}