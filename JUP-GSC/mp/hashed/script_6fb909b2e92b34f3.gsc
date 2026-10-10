/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6fb909b2e92b34f3.gsc
*************************************************/

#using script_7e018ed120c71de8;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_ab78858d3444062c;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  if(getdvarint(@ "hash_b338e81ddf2be38a", 0)) {
    namespace_a304e973fe7f3f00::init();
  }

  level callback::remove("ob_season_main", &main);
}