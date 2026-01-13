/**********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\karatemaster\karatemaster_agent_dlc4.gsc
**********************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\karatemaster::func_DEE8();
  scripts\asm\karatemaster_dlc4\mp\states::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  scripts\mp\agents\karatemaster\karatemaster_agent::func_FAB0();
}