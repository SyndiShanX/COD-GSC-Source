/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\teams.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B14806D156B0B5B9", "_encstr_8F851C1B9CCAB03AACE90E594E161DDBC986AE9BD1DB5B2D4F2CD196F6CD", ::createoperatorcustomization);
  level.teambalance = getdvarint("_encstr_8B03109BC6ED71C1F9AA6D9E18486AC5DEA9");
  level.maxclients = getmaxclients();
  var_0 = ["_encstr_BD78059C33C543", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_9B920B8EAC166BFAD186E49595", "_encstr_8DB30A47B216ADEB99EDAE39", "_encstr_B6B30A098586B0784B5A0B11", "_encstr_93ED097B8081DD415F0BD8", "_encstr_B1CC0BD159B06B7DCD56B356DC", "_encstr_A1B60BB37F81024970B8E081A3", "_encstr_AA710AF177118826982B86DD", "_encstr_84ED0953B9A7AFC980E35E", "_encstr_8DD30CB40BC89DB77D588A8341C0", "_encstr_92A90C5975B1C7E1746F4F7D9057", "_encstr_912F0EB08771A0B743E443D6FB8A1B08", "_encstr_A3B80EC371D0B521FC1717735915CAFE", "_encstr_8FA80DD4E06135611ED70F631FBDC6", "_encstr_871C0DA32B85D6AF6E4B0F1D562B37", "_encstr_AC6F0F48BAB62B1E37653CBD76F381F3DD", "_encstr_BE0D0ED1AF2A89B92D14B9507B1550B0", "_encstr_BD930E14AB683D1758589AD203253735", "_encstr_8EA90CD15D6E5880FB53B1D84BE7", "_encstr_92D910EB10D9E9AFF1ECF51D114F91EFD5D0", "_encstr_88D8106057A11007F37315A88B1B3FFB1FE7", "_encstr_B66D128ECA2CDA7D8EEE9537D1977D8E349CB259", "_encstr_BA9B1101FDD82D96EC60C87BF3B0F732F2939D", "_encstr_BA9B1101FDD82D96EC60C87BF3B0F73292A3B3", "_encstr_97D81043EDA3B237E3C8EF3B28BAFF9B6BFB", "_encstr_911712D1AC2CD6BED1DD95B91D2FEB37B29D56E6", "_encstr_A6F612E3ED2342A7BBBBF1105B72D822B330031B", "_encstr_8EE1113ACA2CADEBD1EEB273A397D7372DCDAC", "_encstr_A5DF0C1D7F32FBF66CB340902B89", "_encstr_B15A10D46BA8FDD795B82AE3436B9F3588C3", "_encstr_BA5A1047CA0BDA7D3A43A5931DBC7D1DEEF6", "_encstr_AD8F12BCDA58EDEFA5EB7AA89173099469A6D8E7", "_encstr_B292118BF8E20349138BC7F3D90BC973988360", "_encstr_9692113A95856B7D1D0D5A9C3A5E7DCC2D9D56", "_encstr_9A5A10A3F1AB0889D370C87EF5C29F7BBBC9", "_encstr_8D8E12C077299F314BB48798D38F066BF27B23B0", "_encstr_9B6C121DB216ADF53A86A593D1BCBE56B4760D47", "_encstr_A3D411A3CA0BB6D78EA15A39D1E5FA372D73B2", "_encstr_8B8E0BA38FA9653F95E02A98A1", "_encstr_9B8E0F2D4F02CBE66EBF68500FBF3815EA", "_encstr_9B8D0F2D4F02CBE66EBF68500FBF5B274A", "_encstr_A9871160929E13264BB7E6DD89878BC1827A10", "_encstr_875E10FB22F7D991FF0FBDB931E93390CF2B", "_encstr_BD5E1093686925B99DE0C27BD3C7E2F95380", "_encstr_868D0F80B741B0A772D53EC5A81907F8B0", "_encstr_B65B11A3CAB0B6AFCCDE9C8E5ED76E2BEC95CD", "_encstr_9569111967E2410166DD439B4077188B3AFB81", "_encstr_929F1011459202A90987FAAB2209FBD01E57", "_encstr_9A9B0B036B1E95EF777B4ED110", "_encstr_AF5D0FA3B2856BEB334B66E82FAFB73756", "_encstr_BA5C0F47CA0BDA7D334B99A35EAFD1DDED", "_encstr_8E5311B40D910F617DE0C2DB583763D32BE52D", "_encstr_BE5E10ED3596F5D1DFCBC2E153D9FC52D5C3", "_encstr_BD5E1093686925B99DE3C77BD3C7E2F95380", "_encstr_845C0FA3775158985AE785B9BF91D630F0", "_encstr_8ED311355F21EF19458C39EBF3CFD72B53A5C2", "_encstr_88A111A3CA2CB5AFCC2D33A3BC7D565AECA147", "_encstr_B1181054EB287D571C185A0362F8DB340843", "_encstr_81AD0B7CB529B7291FB86BA310", "_encstr_8BEA0FC3CAA84809109768413B0750ED2B", "_encstr_BEEA0FEC5390C5DF1E8033FBEA600B3B88", "_encstr_AAB111E33AEFD1998231A1A139E1882BDB5259", "_encstr_BA8A1047CAB0ADBEDC4B3C3A5EFA99DEAE4E", "_encstr_8B8910DB283307310AE0CAB8D30FBFC38453", "_encstr_8DEA0FBDED0F202F4A0A600823692FF803", "_encstr_96EE11A32B855BAFDC2D8747F2D79BCA6759CD", "_encstr_AD36118B617F6701403390840BF957BF943803", "_encstr_82431073BD23A5018B50680199170DE42DA8", "_encstr_AF390D1967E24101735FC3B9855CF8", "_encstr_857D11B34849059997C5E3DFB87133EF50B84F", "_encstr_A97D11C952CE38379BCA33DF58214B5630F3D0", "_encstr_B20A13F4CD51CFA19740030A20A1604FAB237A9D55", "_encstr_AAF512BB9027A099C3B730C5182362676458AB5B", "_encstr_85F512A5C78A437EE31F3050CB1C72EF226C1CA5", "_encstr_837C11942BE8BD9756599B52C02DC7F9A09B20", "_encstr_AD0E1379F5D6E0284F2ABBC1828BF3B9EA4DF5C396", "_encstr_B1EB1391124E2879AF8AF573024B5AB1E36B081C3B", "_encstr_953B12C3180F3D5F6B2BFBD87583581E7048B595", "_encstr_95450CB0424EC3F6B7419C0334AF", "_encstr_93B9105927A20141A59C21D8C3910948EA8F", "_encstr_A7B8108B617F6701F0338F9811C8D9CB9CD8", "_encstr_A7481264DB184D67AD085AB2B3FB2F43289DEDFD", "_encstr_93981103335AFB57D9C0F871F0C9D84A577BE2", "_encstr_8898118E56B05BFAAC963B4347CBBE66B467B2", "_encstr_AAB8103A5658ADAFCAD2D90D3A97EBCD5AE1", "_encstr_85201283E803E5C7191BCFC8ADA2FFAAA3E81ADA", "_encstr_B629124759585BF55996D90DA3CBAF56D2CEA11D", "_encstr_835511E8950BD6EBAC969DA11DF2FAB95A37CA", "_encstr_8A1B0CEB806BFDDF5023FEED455A", "_encstr_AF1810F3EBAFCA4760209DA77B20BF22F073", "_encstr_8D18108E95855BAF37A5DC2BE85EEB3ABBED", "_encstr_8857127330FB5D7F16EA353DB8A3B1733325D162", "_encstr_96D5113368577F26C0019598792061C39F77D0", "_encstr_B8D411C0EBE761EF3DA313CDB4B3E18E874B02", "_encstr_AC181079F5D6E0283BEAB8C123BFE0D86C50", "_encstr_869212ED8FC20B26A667C8987BD97E6F2AF3ED78", "_encstr_A6F912E3ED2342A7F83C90955B72D822B330031B", "_encstr_A31611ABF569C23137B7CE1920FB3140AB228B", "_encstr_93520D9DCD2FAD0FACEBB0E8F38721", "_encstr_9B9B11B40BC89DB7FB7B3AA2A34593D960F55D", "_encstr_8D9B1125074FD047B87B5071C5652349B97B2F", "_encstr_B45A1314AB683D175BDB9AC2C32533791819AA8D33", "_encstr_A76612D1AC58B6EBD057B919C92B19EB33F6BA93", "_encstr_84661243C3E9FDD1534B68D10BD88CB757983B35", "_encstr_919B11018DBE88707B83CD499B27956152E981", "_encstr_811A13E3AF6F77473BCDD829B3DA570716328B1345", "_encstr_88D11319F58B256699FD20551A0A878EBB1B57BCF3", "_encstr_9A2512E82B16D6EB1AAEE61939CAC87DDCD2E62B", "_encstr_889B118E56B05BFA0D577323272BC8F53A5637", "_encstr_8ACD146D0F428BA620974810E34599B7AAF56DF4E74A", "_encstr_888E14E859C2B5FA43D5B9463995C8D7D1BB9536B395", "_encstr_A2C016A30D031297C0786373785964F9F1136CDA6DA32AFE", "_encstr_849D165030A39F81F39508A8EE5029E99978B03B7BAAB923", "_encstr_BE461524FD61FF919190D26AB0D3177F3953BEBC05092B", "_encstr_A30215413FBA1949D0E308414A85C85833B7D1D9D70250", "_encstr_88F817B353CF88A7085B888A6645B3F1CF39B5378B70FAAB9D", "_encstr_96B6178E2B2CDABE435D37329CCA23BE565ACE34D1A3B2AC9B", "_encstr_A20F16EBF387E26F688B850F43289C19E8037B27493D2A06", "_encstr_A38E1443E1804DF1332393387D1DF1B0755417AB3320", "_encstr_840A18D34F7FCF7930F3053B9391C12E8C0FE7C56BA3F7D2082B", "_encstr_BE0A18E34DC3D2570DB8A3B3B89924B9B1DC2F1DAD5B49A40B80", "_encstr_AF211ABC75E9776969184AE2085B9F07E3E4352E153277EB3158E2CA", "_encstr_955D197399878FE943A33E3C85406FFFB573FA5A43638F9F60DB3A", "_encstr_9B5D1995F7BA734EC84FE0A84B1DE1DF139B85100B934F11A16BB0", "_encstr_870A18647DBAF5C1489D922DCE9D37874363E05084A977FB8B80", "_encstr_91FC1A55377AB38E088F20688B5DA19F53DB45D0CB530FF3EDAB7030", "_encstr_97741A40B2BE3306538DC835628FA98F233B70183BD01F196F87C335", "_encstr_8D1C198E95855BAF34D5DC23E4598CAFA3EEB273D1CB7DB92DE695", "_encstr_96E4141D7F32FBF670C77820339569678BA41BA693EB", "_encstr_8C5D183ACAC2B6D70D5D9B46392B23AFD1342DC91DE5EBB7B9B2", "_encstr_865C184B20CB5D7FF04D9E8CE6795B6959E002A3D09399EBCBB8", "_encstr_A2B61A8EAC0BB5D786ABB92339CA23AFD11A4BE43A97BE1D439C592B", "_encstr_A3631969E52610D8D33BA8D173DF0DC93B70DB1D9C88399C27D323", "_encstr_826219A359B0ADF51AAEDCC84ECA46D73A1A5A4EA3F27DCC2DCECA", "_encstr_9B5C1895F7BA734EC84FE0A84B1DE1DF135C831E0B934FB3A153", "_encstr_816F1A9595576390785F0260A24F31C96560386A2D1919FA7DB3B03D", "_encstr_953B1AC3180F3D5F080B9BD072A1B01E3368748253ABE1038887D111", "_encstr_ACA4191BB9633888EABF46019EB34910D9F150638BCBF9B8873A7F", "_encstr_93C413AB057B6A9FC8606B4B70419CF1DDA8B223F3", "_encstr_B65E17A3CAB0B6AF0DEA9B8C9C598CFACCBD4EA397D7DE7359", "_encstr_AD5E173A590B5BBE0DABCD19E45919D733DB9C8E5ED71DDD7B", "_encstr_AFA819B301A0C551AB732B1B65C52A3F60A8AA3B3AF9845AFE7B0F", "_encstr_99421818AF6310A0504B4629D888FFDF922FB8D337016B6A6B9B", "_encstr_924218C9454670B8B35BC871D37FED295FD74D71F1A150FBE372", "_encstr_8F5E17642BC72739518BB8EC9E033717A87043E3B9CF8FC0BB", "_encstr_97EA19D1B2C26BD734BADC91935619AF99BD93E8F2F5B9599D9537", "_encstr_8C21195BF58B9A0F58F0DBFBE0D1EC616D1822D3634F5271C1438B", "_encstr_8601182BD0D16DF1D9B58D071EFB7A179918BB53584ED65A3D45", "_encstr_8CB3136505E7C8D7742308A0ABCF694623A1E4DD81", "_encstr_9A011720D2DE536633EDA895C22F496F477AC8A88BF99F98FF", "_encstr_850117A32B0B5BBE43D53732279523FACC4BCCA35E7D8EBBDE", "_encstr_A970197BAF99905082DFCDD1EB7A05B93604A1F3D0FF10F3FB67C3", "_encstr_9B1218238D83921740F8E3F3F8D9E47955132FDB6B579A7F8BA8", "_encstr_851318D31542051E5C7BE58372E349E97C63AA2CB0FFA228F33B", "_encstr_BE0117D361C0A5318B530B3B4525CADF4048CF5B1AD9636ADB", "_encstr_93A0194BD06179B141ADBD9263D7934F7619411B70EE8FE316D5DD", "_encstr_B4F9194B9FA9A060520F3D213BAA35E94674F1C35E2FA823DA6331", "_encstr_AFCC183ACA85DAF5A1AE9B9139CA46FA33A566472FEBB9D2CDAC", "_encstr_863813A1DF5AF9A93003A8E1EAE5A8389317313907", "_encstr_9B7D17F35D3322A7F0A8B383888954C9AFE3786B3B275AAE79", "_encstr_917D17A3B2C2B6FAD0D5DC199C5691AFDCB4C3E8BCEB1DDDB7", "_encstr_9103196BAF2A2BAFBCF866C49B112BA18AF720194BCFC8203D5B07", "_encstr_8D1F1853B9A7AFC960C35E5CA5604F1FD6500BDB82104B3D50F5", "_encstr_A61F1853A8A9E579412D05BF9673828FB3A01BDBD0C626C285CD", "_encstr_937D17E8AC2CB57D86EA9B23E42B23F5CD2DC3D1CB7DE6963C", "_encstr_A14C19D30ADFE1A9543D9DF1427F38A0CF62EA5B53CF26A0EB0595", "_encstr_BA7E1910518785E7B0B390059530A0DFC7D9D01343281F3B994341", "_encstr_AC6018281FE9283FFA2B5855C20281D64387D0A017BFCD6B42D7", "_encstr_AFC215130B0F6AE7F0033D87DBA0E481DE9393AFF52D93", "_encstr_AAED19B84A46FBCE8B45370D3AC7D1D7AAD2208852DB2B06BF769D", "_encstr_8FED197CA8B9C73950C37B8C8AA71A59701033AD75637067880FA7", "_encstr_A9951BF9755660A8A3AB3861C34FFD396ACD7543167B9890FB92B3499A", "_encstr_AA381A5CE320754F0393A20A1BEDFBA1185BD6D51D70B8873CC86B73", "_encstr_96381A3DEA073DB808CBA5EAC237B1A08B174BA038FB40EF3C2A036A", "_encstr_A7ED19A3BBDFBA3720F3CD570B1054D1AEC3237F05FD23FF105840", "_encstr_A6C01B1CB7874D6F89BDC8E7936D48FFF6BD5B3F26DB1B6F861F451D5A", "_encstr_84191B8EB2B05BFA34BAB932392B46BEDCCA67599BA3F2F556B49D0DD1", "_encstr_99F61A8E56855BFA1AD5DC469CCA8CBEB9CAB359E6A3BCEBDC2D7356", "_encstr_834C141DACC26BBE435D37239CACC8F559A53B1A3ABC", "_encstr_884D183A59C2DA7D0DD59BC8935691BE95B47686E8E5FADEE62B", "_encstr_8F4D18784FB9786F4A9B888532F25166E5D758109349F6E18305", "_encstr_85E01A47B22CADFA1A5DB9C8C95946FA56A59D1AA3BCBEA30D9C5959", "_encstr_9AAE19FDAD4F606FCC8B90C8D3A7C1FEB7598C7B14976E55759348", "_encstr_B8AE19832591C58958F5FE42A580AC8E9F4A1753704B493721B32A", "_encstr_874D182B40AB3D1F50ED3E2C0699BBC9DB48826270337957A853", "_encstr_AF0B1ABB6F595090C29F8D91AB3A4579F5C441B0D39909BE4AEB83BD", "_encstr_82FE1A53B9A7AFC960C35E5CA5604F1FDD50FA1A2303AFBFB0DF4034", "_encstr_BD6C190BE1FFE781188B06149DA897E71598B2526B4B7785789505", "_encstr_97B914738889C559610D25DFF613A2AF3040A3BF9862", "_encstr_A50F1873A76168A88AC7C5E9E3620DB1363CB8298BD14178026F", "_encstr_830F188ECA0B6BAF1A57E646E4B219BEE6B4B9ACE8977DD177B7", "_encstr_8D541A0BFF27E291017B6819EEFB4539B09C23281CF3DE3BA8BD177F", "_encstr_8CF119380FF9382F0ADB4845F23291A62E975038D389360542C3BE", "_encstr_92F119D195C2AD7D43ABB932932B19AF374B73AC4797F5CC96D956", "_encstr_8E0F181D7F32FBF670C77820339569672AE4982D93EBD73B29CB", "_encstr_ADD21AF4E3E86B9811E0E01546B94168AD99D5131423F7E3D254ABD3", "_encstr_A2311A5927A20141A89BCD59428DD050EABFF5F39BCBC0A8F177C853", "_encstr_B4AE194756C2AD7DD0EADC194ECA46EBE64BB9CAA32F7DE6A5DC56", "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8", "_encstr_AF8C0A1B6A1D6045925B4F7D", "_encstr_933E090A10B17DDFB3E522"];
  level.allteamnamelist = var_0;
  var_1 = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08"];
  var_2 = ["_encstr_81190407A676", "_encstr_921F052955D419", "_encstr_83E4052BCF5026", "_encstr_AF18056FA33E78"];
  var_3 = scripts\mp\utility\teams::getcustomgametypeteammax();
  var_3 = min(var_3, getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8C040BBEA3CAB0B5C6B7D5373A", -1));

  if(!isDefined(level.teammaxfill)) {
    if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_99F00DEB8E950BD6B52CC399D2B1C6", -1) != -1)
      level.teammaxfill = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_99F00DEB8E950BD6B52CC399D2B1C6", 1) > 0;
    else
      level.teammaxfill = var_3 == 50;
  }

  level.maxteamsize = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_BEA80A1E58376F9833A3E30F", 0);
  level.maxsquadsize = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8D2B0B5FF8373DC16C1FA7CB6B", 4);
  var_4 = 1;
  var_5 = -1;

  if(var_3 >= 3) {
    for(var_6 = 3; var_6 < var_3 + var_4; var_6++) {
      var_1[var_1.size] = level.allteamnamelist[var_6];

      if(!isDefined(game[level.allteamnamelist[var_6]]))
        game[level.allteamnamelist[var_6]] = var_2[(var_6 + var_5) % var_2.size];
    }
  }

  var_7 = _id_132E6();

  if(var_7 && !scripts\engine\utility::array_contains(var_1, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8"))
    level.teamnamelist = scripts\engine\utility::array_add(var_1, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");
  else
    level.teamnamelist = var_1;

  level.multiteambased = level.teamnamelist.size > 2 || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\menus::_id_13733();
  level.teamdata = [];

  foreach(var_9 in var_0) {
    level.teamdata[var_9] = [];
    level.teamdata[var_9]["_encstr_9775086022BE1B413B8B"] = [];
    level.teamdata[var_9]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"] = [];
    level.teamdata[var_9]["_encstr_AB580A05672AE35D5FFF50B8"] = 0;
    level.teamdata[var_9]["_encstr_8A2A0B936CCCC3078547970A8B"] = 0;
    level.teamdata[var_9]["_encstr_B8DF0B365AD9593734B7D5DC1D"] = 0;
    level.teamdata[var_9]["_encstr_A1310B432F9BDEFBEF4393B0F1"] = 0;
    level.teamdata[var_9]["_encstr_AC610CF033ED0C4B1A6B45D30502"] = 0;
    level.teamdata[var_9]["_encstr_A96C087B2B97994D62DB"] = 0;
    level.teamdata[var_9]["_encstr_A63208900AB769596374"] = 0;

    if(level.multiteambased)
      level.teamdata[var_9]["_encstr_8B340BAAD957B3BA5DD33DBB1B"] = 0;
  }

  foreach(var_9 in var_1) {
    scripts\mp\utility\teams::rpgafterspawnfunc(var_9);
    scripts\mp\utility\teams::getteamname(var_9);
    scripts\mp\utility\teams::getteamshortname(var_9);
    scripts\mp\utility\teams::getteamicon(var_9);
    scripts\mp\utility\teams::getteamheadicon(var_9);
    scripts\mp\utility\teams::getteamvoiceinfix(var_9);
  }

  level.teambased = var_3 > 1;

  if(scripts\mp\utility\game::unset_relic_grounded()) {}

  setDvar("_encstr_ACE80C9B42163A38019860590597", level.teamnamelist.size);

  if(getdvarint("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D") > 1 && level.teambased)
    level thread scripts\cp_mp\killstreaks\uav::setforceradars(undefined, 1);

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);
  level thread onplayerconnect();
  level thread trackplayedtime();
  initoperatorcustomization();
  initnightvisionheadoverrides();
  wait 0.15;
  level thread updateplayertimes();
  level thread finalizeplayertimes();

  if(level.teambased)
    level thread updateteambalance();

  if(scripts\mp\utility\game::matchmakinggame() && !dotournamentendgame() && !getdvarint("_encstr_8EBD1537D84EF591969BB0311BB2F585E6472DF52C33AD", 0))
    level thread watchafk();

  if(isDefined(level.playerentersafearea))
    level thread[[level.playerentersafearea]]();

  if(getdvarint("_encstr_9AC8108F6126C73B61C0ABA96763955F0903", 0) == 1)
    level thread istempsfxent();
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.timeplayed = [];
    var_0.timeplayed["_encstr_B472054FE12550"] = 0;
    var_0.timeplayed["_encstr_BE7D0633C08849E2"] = 0;
    var_0.timeplayed["_encstr_93C20CED035F8BA928B8834FE840"] = 0;
    var_0.timeplayed["_encstr_8261067B1D34AC27"] = 0;
    var_0.timeplayed["_encstr_8E6E097D1C928BB55DB708"] = 0;
    var_0.timeplayed["_encstr_9B220634456A5747"] = 0;
    var_0.timeplayed["_encstr_82D10F60A26E2BB3D36026A553EB19AFD5"] = 0;
  }
}

onjoinedteam(var_0) {
  var_0 updateteamtime();
}

onjoinedspectators(var_0) {
  if(isDefined(var_0.pers))
    var_0.pers["_encstr_970F096917923129F9CD31"] = undefined;
}

trackplayedtime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(!level.gameended) {
    wait 1.0;

    foreach(var_1 in level.players)
    var_1 trackplayedtimeupdate();
  }
}

trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    var_0 = self.sessionteam;

    if(!isDefined(self.timeplayed["_encstr_B472054FE12550"]))
      self.timeplayed["_encstr_B472054FE12550"] = 0;
    else
      self.timeplayed["_encstr_B472054FE12550"]++;

    if(var_0 != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_0 != "_encstr_933E090A10B17DDFB3E522") {
      self.timeplayed["_encstr_BE7D0633C08849E2"]++;
      self.timeplayed["_encstr_93C20CED035F8BA928B8834FE840"]++;

      if(!scripts\mp\utility\player::isreallyalive(self))
        self.timeplayed["_encstr_8E6E097D1C928BB55DB708"]++;
    }
  }
}

updateplayertimes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = level.players.size;

    for(var_1 = 0; var_1 < var_0; var_1 = var_1 + 20) {
      scripts\mp\hostmigration::waittillhostmigrationdone();

      for(var_2 = 0; var_2 < 20; var_2++) {
        var_3 = var_1 + var_2;
        var_4 = level.players[var_3];

        if(isDefined(var_4))
          var_4 updateplayedtime();
      }

      waitframe();
    }

    wait 10.0;
  }
}

finalizeplayertimes() {
  while(!level.gameended)
    wait 2.0;

  foreach(var_1 in level.players) {
    var_1 updateplayedtime();

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      var_1 scripts\mp\persistence::writebufferedstats();
      var_1 scripts\mp\persistence::updateweaponbufferedstats();
    }
  }
}

updateplayedtime() {
  if(isai(self)) {
    return;
  }
  scripts\mp\playerstats_interface::addtoplayerstatbuffered(self.timeplayed["_encstr_B472054FE12550"], "_encstr_AA270B12190951B94784B87C6B", "_encstr_8893104796DA2B14B185E5B2198A7BE80B36");
  scripts\mp\persistence::stataddchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", self.timeplayed["_encstr_B472054FE12550"], 1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
    self.timeplayed["_encstr_9B220634456A5747"] = self.timeplayed["_encstr_9B220634456A5747"] + self.timeplayed["_encstr_B472054FE12550"];
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_A5711EFBE72B193841670BA30E09C8C3620F457B4B42DE5878BA913B72E91888())
    self.timeplayed["_encstr_82D10F60A26E2BB3D36026A553EB19AFD5"] = self.timeplayed["_encstr_82D10F60A26E2BB3D36026A553EB19AFD5"] + self.timeplayed["_encstr_B472054FE12550"];

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    return;
  }
  self.timeplayed["_encstr_B472054FE12550"] = 0;
  self.timeplayed["_encstr_93C20CED035F8BA928B8834FE840"] = 0;
}

updateteamtime() {
  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B") {
    return;
  }
  self.pers["_encstr_970F096917923129F9CD31"] = gettime();
}

updateteambalancedvar() {
  for(;;) {
    var_0 = getdvarint("_encstr_8B03109BC6ED71C1F9AA6D9E18486AC5DEA9");

    if(level.teambalance != var_0)
      level.teambalance = getdvarint("_encstr_8B03109BC6ED71C1F9AA6D9E18486AC5DEA9");

    wait 1;
  }
}

updateteambalance() {
  level thread updateteambalancedvar();
  wait 0.15;

  if(level.teambalance && scripts\mp\utility\game::isroundbased()) {
    if(isDefined(game["_encstr_AB0A1690851B85CDB15651B2C26B9B39593CA325EDABDC32"]))
      scripts\mp\hud_message::showerrormessagetoallplayers("_encstr_A7CA1ADCF2FF679FD1610D7DD10F1D20C7394D9F8B745935D72F19AD");

    level waittill("_encstr_92DF0B127AF74B41D63488E317");

    if(isDefined(game["_encstr_AB0A1690851B85CDB15651B2C26B9B39593CA325EDABDC32"])) {
      level balanceteams();
      game["_encstr_AB0A1690851B85CDB15651B2C26B9B39593CA325EDABDC32"] = undefined;
    } else if(!getteambalance())
      game["_encstr_AB0A1690851B85CDB15651B2C26B9B39593CA325EDABDC32"] = 1;
  } else {
    level endon("_encstr_9B1D0BC7932875276230426AA1");

    for(;;) {
      if(level.teambalance) {
        if(!getteambalance()) {
          scripts\mp\hud_message::showerrormessagetoallplayers("_encstr_A24A17F30738CFE759675DBD0329ED8EA7B6FF55E9185DEF2F", 15);
          wait 15.0;

          if(!getteambalance())
            level balanceteams();
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

getteambalance() {
  var_0["_encstr_9A8507BA4040188D08"] = 0;
  var_0["_encstr_8E8405EA382B2A"] = 0;
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].pers["_encstr_8AEF05472BC2D6"]) && var_1[var_2].pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
      var_0["_encstr_9A8507BA4040188D08"]++;
      continue;
    }

    if(isDefined(var_1[var_2].pers["_encstr_8AEF05472BC2D6"]) && var_1[var_2].pers["_encstr_8AEF05472BC2D6"] == "_encstr_8E8405EA382B2A")
      var_0["_encstr_8E8405EA382B2A"]++;
  }

  if(var_0["_encstr_9A8507BA4040188D08"] > var_0["_encstr_8E8405EA382B2A"] + level.teambalance || var_0["_encstr_8E8405EA382B2A"] > var_0["_encstr_9A8507BA4040188D08"] + level.teambalance)
    return 0;
  else
    return 1;
}

balanceteams() {
  iprintlnbold(game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_996A0C3F03B3C09168F92F8807EA"]);
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3].pers["_encstr_970F096917923129F9CD31"])) {
      continue;
    }
    if(isDefined(var_2[var_3].pers["_encstr_8AEF05472BC2D6"]) && var_2[var_3].pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
      var_0[var_0.size] = var_2[var_3];
      continue;
    }

    if(isDefined(var_2[var_3].pers["_encstr_8AEF05472BC2D6"]) && var_2[var_3].pers["_encstr_8AEF05472BC2D6"] == "_encstr_8E8405EA382B2A")
      var_1[var_1.size] = var_2[var_3];
  }

  var_4 = undefined;

  while(var_0.size > var_1.size + 1 || var_1.size > var_0.size + 1) {
    if(var_0.size > var_1.size + 1) {
      for(var_5 = 0; var_5 < var_0.size; var_5++) {
        if(isDefined(var_0[var_5].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(var_4)) {
          var_4 = var_0[var_5];
          continue;
        }

        if(var_0[var_5].pers["_encstr_970F096917923129F9CD31"] > var_4.pers["_encstr_970F096917923129F9CD31"])
          var_4 = var_0[var_5];
      }

      var_4[[level.onteamselection]]("_encstr_8E8405EA382B2A");
    } else if(var_1.size > var_0.size + 1) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isDefined(var_1[var_5].dont_auto_balance)) {
          continue;
        }
        if(!isDefined(var_4)) {
          var_4 = var_1[var_5];
          continue;
        }

        if(var_1[var_5].pers["_encstr_970F096917923129F9CD31"] > var_4.pers["_encstr_970F096917923129F9CD31"])
          var_4 = var_1[var_5];
      }

      var_4[[level.onteamselection]]("_encstr_9A8507BA4040188D08");
    }

    var_4 = undefined;
    var_0 = [];
    var_1 = [];
    var_2 = level.players;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(isDefined(var_2[var_3].pers["_encstr_8AEF05472BC2D6"]) && var_2[var_3].pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
        var_0[var_0.size] = var_2[var_3];
        continue;
      }

      if(isDefined(var_2[var_3].pers["_encstr_8AEF05472BC2D6"]) && var_2[var_3].pers["_encstr_8AEF05472BC2D6"] == "_encstr_8E8405EA382B2A")
        var_1[var_1.size] = var_2[var_3];
    }
  }
}

playermodelforweapon(var_0, var_1) {}

countplayers() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++)
    var_0[level.teamnamelist[var_1]] = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      continue;
    }
    if(level.players[var_1].pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(level.players[var_1].pers["_encstr_8AEF05472BC2D6"] == "_encstr_933E090A10B17DDFB3E522") {
      continue;
    }
    if(isDefined(level.players[var_1].pers["_encstr_8AEF05472BC2D6"]))
      var_0[level.players[var_1].pers["_encstr_8AEF05472BC2D6"]]++;
  }

  return var_0;
}

setcharactermodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(!isagent(self)) {
    var_0 = self getcustomizationbody();
    var_1 = self getcustomizationhead();
    var_2 = self getcustomizationviewmodel();
  }

  self setModel(var_0);
  self setviewmodel(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "_encstr_B40101", 1);
    self.headmodel = var_1;
  }
}

forcecustomization(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];

  switch (var_0) {
    case 1:
      var_1 = "_encstr_9A7017FDB76657DE6548E21A20B1178BDE16776C4B0E1669CF";
      var_2 = "_encstr_AA79174151AFF7070BCF6894C995B2CB79102D7A135F6F215F";
      break;
    case 2:
      var_1 = "_encstr_81F512D749E1EA171F9080D0D34B83309FB706EA";
      var_2 = "_encstr_B8B212C5AFAFC00779E4CF828BA0BE4A11CFF73A";
      break;
    case 3:
      if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163") {
        var_1 = "_encstr_91F615B6C17D9BBCE60BC1A32D1BD731F68CBCF526AFA1";
        var_2 = "_encstr_993D15DA88B7DAE73047809C6BB9B7A47BA8D271FADF43";
      } else {
        var_1 = "_encstr_A7F6156B38BECD2FCD2C1C475AD87D26B746CBBE4CAF89";
        var_2 = "_encstr_A13D156BE0BEB9E5E60B38D1A58DD786560B23F589EB62";
      }

      break;
    case 4:
      var_1 = "_encstr_85A6105537AF726C90D9A38F186A0F6FD7EF";
      var_2 = "_encstr_92E010D52B470954D91FA8CF111F79C61E7E";
      break;
    case 5:
      var_1 = "_encstr_853714332B1956508AA068A18A7F388002B7DF15FF87";
      var_2 = "_encstr_819C14733889C3850363BA4536989B781F626F4A98C1";
      break;
    case 6:
      var_1 = "_encstr_AAF512DF38DFF054DF3220D87840C141F8935173";
      var_2 = "_encstr_8315127DD8A0E723780A7BB9A9D53994B9AAF167";
      break;
  }

  self setcustomization(var_1, var_2);
  var_4 = self getcustomizationbody();
  var_5 = self getcustomizationhead();
  var_6 = self getcustomizationviewmodel();
  setcharactermodels(var_4, var_5, var_6);
}

getcustomization() {
  var_0 = [];

  if(isDefined(self.operatorcustomization)) {
    var_0["_encstr_AD9B0589ED9197"] = self.operatorcustomization.body;
    var_0["_encstr_81CC0586952C91"] = self.operatorcustomization.head;
  } else {
    var_1 = getoperatorcustomization();
    var_0["_encstr_AD9B0589ED9197"] = var_1[0];
    var_0["_encstr_81CC0586952C91"] = var_1[1];
  }

  return var_0;
}

setmodelfromcustomization() {
  var_0 = getcustomization();
  self setcustomization(var_0["_encstr_AD9B0589ED9197"], var_0["_encstr_81CC0586952C91"]);
  var_1 = self getcustomizationbody();
  var_2 = self getcustomizationhead();
  var_3 = self getcustomizationviewmodel();
  setcharactermodels(var_1, var_2, var_3);
}

getplayercustomization() {
  return getoperatorcustomization();
}

getplayerbodymodel() {
  var_0 = getoperatorcustomization();
  return var_0[0];
}

getplayerheadmodel() {
  var_0 = getoperatorcustomization();
  return var_0[1];
}

getplayerviewmodelfrombody(var_0) {
  var_1 = tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_0, 3);

  if(!isDefined(var_1) || var_1 == "_encstr_B40101")
    var_1 = "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C";

  return var_1;
}

getplayerfoleytype(var_0) {
  return tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_0, 5);
}

getplayermodelname(var_0) {
  return tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 0, var_0, 1);
}

setupplayermodel() {
  var_0 = 1;

  if(istrue(var_0)) {
    var_1 = undefined;
    var_2 = undefined;

    if(!isDefined(self.operatorcustomization) || self.operatorcustomization.rebuild == 1)
      createoperatorcustomization();

    setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
    scripts\mp\utility\player::_setsuit(self.operatorcustomization.suit);
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
    return;
  }

  if(isai(self))
    var_3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.loadoutarchetype) + 1;
  else if(isDefined(self.changedarchetypeinfo))
    var_3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.changedarchetypeinfo.archetype) + 1;
  else
    var_3 = getdvarint("_encstr_870D0F99F69CB1B2A027361AAC8E2FC1CA", 0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && self.team == "_encstr_8E8405EA382B2A")
    var_3 = 3;

  if(isPlayer(self) && var_3 == 0)
    setmodelfromcustomization();
  else
    forcecustomization(var_3);

  self.voice = "_encstr_867506BC13B8C367";

  if(scripts\mp\utility\game::isanymlgmatch() && !isai(self)) {
    var_4 = getplayerbodymodel();

    if(issubstr(var_4, "_encstr_AB1D108E0388F57B407193F97B288F2A68B5"))
      thread forcedefaultmodel();
  }
}

setuppingspecificvars(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A7B5194AE1F843CDF04B84841D08DDDB957B5213884EC744F81593");
  self endon("_encstr_A7B5194AE1F843CDF04B84841D08DDDB957B5213884EC744F81593");
  var_1 = "_encstr_8BB610607BBC8B03496D97150282619002AF";
  var_2 = "_encstr_A7A408B9CA5D1D4E2C63";

  if(!self isscriptable() || !self getscriptablehaspart(var_1)) {
    return;
  }
  var_3 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_0, 26);

  if(isDefined(var_3) && var_3 != "_encstr_B40101") {
    self setscriptablepartstate(var_1, var_3);
    self waittill("_encstr_AD75063D571AE108");
    self setscriptablepartstate(var_1, var_2);
  } else
    self setscriptablepartstate(var_1, var_2);
}

createoperatorcustomization() {
  if(isai(self) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    self.botoperatorref = undefined;
    self.botoperatorteam = undefined;
    self.botskinid = undefined;
  }

  var_0 = getoperatorcustomization();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];

  if(!isagent(self)) {
    self setcustomization(var_1, var_2);
    var_4 = self getcustomizationbody();
    var_5 = self getcustomizationhead();
    var_6 = self getcustomizationviewmodel();
    var_7 = getplayerviewmodelfrombody(var_1);
  } else if(level.gametype == "_encstr_B607038AAB") {
    var_4 = "_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974";
    var_5 = undefined;
    var_6 = "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C";
    var_7 = "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C";
  } else {
    var_4 = "_encstr_9BB12213BDC897EBB70733BDC9362B7D1BEDE6237B73FAE8599393F6932DB9E8F589D746";
    var_5 = "_encstr_B1BB1014B72AFA0761C250022FAEB0C8AA0B";
    var_6 = "_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707";
    var_7 = "_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707";
  }

  var_8 = lookupcurrentoperator(self.team);
  var_9 = lookupcurrentoperatorskin(self.team);

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && self.team == "_encstr_8E8405EA382B2A") {
    var_8 = "_encstr_8B1B10E7D8E125229366B137C767CBFDEBC0";
    var_9 = 218;
  }

  var_10 = spawnStruct();
  var_10.operatorref = var_8;
  var_10.skinref = var_9;
  var_10.body = var_1;
  var_10.defaultbody = var_4;
  var_10.head = var_2;
  var_10.defaulthead = var_5;
  var_10.vm = var_7;
  var_10.defaultvm = var_6;
  var_10.gender = getoperatorgender(var_8);
  var_10.voice = getoperatorvoice(var_8, var_9);
  var_10.title = resettimeronpickup(var_8);
  var_10.clothtype = resetplayermovespeedscale(var_9);
  var_10.superfaction = getoperatorsuperfaction(var_8);
  var_10.execution = getoperatorexecution(var_8);
  var_10.oic_rewardammo = resetposition(var_8);
  var_10.oicvariantid = resetscorefeedcontrolomnvar(var_8);
  var_10.suit = var_3;
  var_10.rebuild = 0;
  var_10.spawn_carriables_from_prefabs_percentage = update_timer_for_bomb_vest_detonator_holder(var_1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_11 = resetplayerdataforrespawningplayer(var_9);

    if(var_11 != "_encstr_B40101")
      var_10.disabledebugdialogue = var_11;

    thread setuppingspecificvars(var_9);

    if(resetsuper(var_8) == "_encstr_BD0703AF7C")
      self._id_12E3A = 1;
  }

  var_12 = spawnStruct();
  var_12.apc = runbrgametypefunc6("_encstr_8C1904676089");
  var_12.c4_pick_up_listener = rundomplateskybeam("_encstr_8C1904676089");
  var_12.check_cannot_spawn_tank = runbrgametypefunc6("_encstr_8C190467402B");
  var_12.get_extra_focus_fire_multipler = runbrgametypefunc6("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6");
  var_12.vehicle_damage_endburndown = runbrgametypefunc6("_encstr_85DE05A6B2AC0E");
  var_12.x1opsenableelimination = runbrgametypefunc6("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");
  var_12._id_139F7 = runbrgametypefunc6("_encstr_9A120A1D8536F5E4ED3BB293");
  var_12._id_13A47 = runbrgametypefunc6("_encstr_967E0A830E45C7671D993353");
  var_12._id_13A48 = rundomplateskybeam("_encstr_967E0A830E45C7671D993353");
  var_12._id_13A52 = runbrgametypefunc6("_encstr_A9F00A8E85CD6DEBBBCAE6D1");
  var_12._id_13A53 = rundomplateskybeam("_encstr_A9F00A8E85CD6DEBBBCAE6D1");
  var_12._id_11D4D = runbrgametypefunc6("_encstr_99C20BA548E9F27A61D897932B");
  var_12.br_is_allowed_armor_insert = runbrgametypefunc6("_encstr_82BB09C9BC9A68D9E243CB");
  var_12.create_head_icon_for_crate = runbrgametypefunc6("_encstr_B4920771CA8F0618B2");
  var_12._encstr_91F511673FA9BB292DD8BAE321179E73A328F3 = runbrgametypefunc6("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3");
  var_12._encstr_8CEF1807A88FA060639211BB592F2718621FA7EF3473883E679B = rundomplateskybeam("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3");
  var_12.c130airdrop_heightoverride = runcircles("_encstr_8C1904676089", 4);
  var_12.check_carrier_status = runcircles("_encstr_8C190467402B", 6);
  var_12.get_fake_digit_from_pool = runcircles("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", 8);
  var_12.vehicle_damage_enginevisualclearcallback = runcircles("_encstr_85DE05A6B2AC0E", 10);
  var_12.x1opsendgame = runcircles("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", 12);
  var_12._id_139F8 = runcircles("_encstr_9A120A1D8536F5E4ED3BB293", 14);
  var_12._id_11D5F = runcircles("_encstr_99C20BA548E9F27A61D897932B", 16);
  var_12._encstr_858C16A71ADFAD5F40D0D16009AA4A7379780FFE6C2FAEFB = runcircles("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 18);
  var_12.check_for_damage_scalar_change = runcontrolledcallback("_encstr_8C190467402B");
  var_12._id_139FC = runcontrolledcallback("_encstr_9A120A1D8536F5E4ED3BB293");
  var_12.zombieingas = runcontrolledcallback("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");
  var_12._id_11D70 = runcontrolledcallback("_encstr_99C20BA548E9F27A61D897932B");
  var_12.br_isplayerbeforeinitialinfildeploy = runcontrolledcallback("_encstr_82BB09C9BC9A68D9E243CB");
  var_12.createjuggdroplocation = runcontrolledcallback("_encstr_B4920771CA8F0618B2");

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    if(isbot(self)) {
      if(self.team == "_encstr_9A8507BA4040188D08")
        var_10.voice = "_encstr_A235065B1FD28D32";
      else
        var_10.voice = "_encstr_846A06C2E309E44A";
    }
  }

  self.operatorcustomization = var_10;
  self._id_14238 = var_12;
}

respawntokenenabled(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_AA5C0AFFB72143DE697B535B", var_0);
}

respawntokendisabled(var_0) {
  if(getlocalestructarray()) {
    var_1 = scripts\engine\utility::ter_op(var_0 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

    if(isDefined(self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"])) {
      var_2 = self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"][var_1];

      if(isDefined(var_2))
        return var_2.operatorref;
    }

    var_3 = respawntokenenabled(var_0);

    if(update_track_operational_status(var_3)) {
      if(!isDefined(self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"]))
        self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"] = [];

      var_2 = spawnStruct();
      var_4 = getarraykeys(level.operatorcustomization[var_1]);
      var_3 = scripts\engine\utility::random(var_4);
      var_2.operatorref = var_3;
      var_5 = getarraykeys(level.operatorcustomization[var_1][var_3]);
      var_6 = scripts\engine\utility::random(var_5);
      var_2._id_12137 = int(tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 1, var_6, 0));
      self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"][var_1] = var_2;
    }
  } else
    var_3 = respawntokenenabled(var_0);

  return var_3;
}

restart_watcher(var_0) {
  if(getlocalestructarray()) {
    if(isDefined(self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"])) {
      var_1 = getoperatorteambyref(var_0);
      var_2 = self.pers["_encstr_A28E1793CADCD1C9B41B3A95919E38B22785E8B7C94ACD99DE"][var_1];

      if(isDefined(var_2))
        return var_2._id_12137;
    }
  }

  return self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_0, "_encstr_8D18056EADA59B");
}

getlocalestructarray() {
  if(!isDefined(level._id_12134)) {
    level._id_12134 = spawnStruct();
    var_0 = getDvar("_encstr_8A201E9B1B27EB7B38B293583AF69CF54E95E61DC94B6CA3AFDCF6ABC9C695CD");
    level._id_12134.sources = strtok(var_0, "_encstr_964C0249");

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      level._id_12134.sources = ["_encstr_AF0703BB78", "_encstr_BD0703AF7C"];

    level._id_12134.enabled = !!level._id_12134.sources.size;

    if(level._id_12134.enabled)
      level._id_12134.use_emp_drone_func = [];
  }

  return level._id_12134.enabled;
}

update_track_operational_status(var_0) {
  if(!getlocalestructarray())
    return 0;

  var_1 = level._id_12134.use_emp_drone_func[var_0];

  if(!isDefined(var_1)) {
    var_1 = 0;
    var_2 = resetsuper(var_0);

    foreach(var_4 in level._id_12134.sources) {
      if(var_2 == var_4) {
        var_1 = 1;
        break;
      }
    }

    level._id_12134.use_emp_drone_func[var_0] = var_1;
  }

  return var_1;
}

lookupotheroperator(var_0) {
  if(!isPlayer(self) && !isai(self))
    return "_encstr_B40101";

  var_1 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", 1, 0);
  var_2 = self getentitynumber();
  var_3 = "_encstr_B40101";
  var_0 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  if(level.gametype != "_encstr_B607038AAB") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[var_2][var_0])) {
        var_4 = spawnStruct();
        var_4.operatorref = respawntokendisabled(var_1);
        level.playercustomizationdata[var_2][var_0] = var_4;
      }

      var_3 = level.playercustomizationdata[var_2][var_0].operatorref;
    }
  }

  return var_3;
}

lookupcurrentoperator(var_0) {
  if(!isPlayer(self) && !isai(self))
    return "_encstr_B40101";

  var_1 = scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", 0, 1);
  var_2 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";

  if(!level.teambased || var_2) {
    var_3 = undefined;

    if(isai(self))
      var_3 = self.botoperatorteam;
    else
      var_3 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_B483160271B8BDE2F50353875115BBF12098FA048810458B");

    var_1 = var_3;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(var_1 == 0)
        self.defaultoperatorteam = "_encstr_9A8507BA4040188D08";
      else
        self.defaultoperatorteam = "_encstr_8E8405EA382B2A";
    }
  }

  if(!isDefined(level.playercustomizationdata))
    level.playercustomizationdata = [];

  var_4 = self getentitynumber();

  if(!isDefined(level.playercustomizationdata[var_4]))
    level.playercustomizationdata[var_4] = [];

  var_5 = undefined;

  if(level.gametype == "_encstr_AAE507E8423F63C163" && var_0 == "_encstr_8E8405EA382B2A") {
    var_6 = spawnStruct();
    var_6.operatorref = "_encstr_8B1B10E7D8E125229366B137C767CBFDEBC0";
    level.playercustomizationdata[var_4][var_0] = var_6;
  } else if(!isDefined(level.playercustomizationdata[var_4][var_0])) {
    var_6 = spawnStruct();

    if(isai(self))
      var_6.operatorref = self.botoperatorref;
    else
      var_6.operatorref = respawntokendisabled(var_1);

    level.playercustomizationdata[var_4][var_0] = var_6;
  }

  var_5 = level.playercustomizationdata[var_4][var_0].operatorref;

  if(getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt()) {
    var_7 = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.showempminimap)) {
      foreach(var_9 in var_7) {
        var_10 = getarraykeys(level.operatorcustomization[var_9]);

        if(!isDefined(level.showing_ui_record))
          level.showing_ui_record = [];

        if(!isDefined(level.showing_ui_record[var_9]) || level.showing_ui_record[var_9] > var_10.size)
          level.showing_ui_record[var_9] = 0;

        for(var_11 = var_10[level.showing_ui_record[var_9]]; isDefined(var_11) && (var_11 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65" || var_11 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B"); var_11 = var_10[level.showing_ui_record[var_9]]) {
          level.showing_ui_record[var_9] = level.showing_ui_record[var_9] + 1;

          if(level.showing_ui_record[var_9] > var_10.size)
            level.showing_ui_record[var_9] = 0;
        }

        level.showing_ui_record[var_9] = level.showing_ui_record[var_9] + 1;
        level.playercustomizationdata[var_4][var_9] = spawnStruct();
        level.playercustomizationdata[var_4][var_9].operatorref = var_11;
      }

      self.showempminimap = 1;
    }

    if(isDefined(level.operatorcustomization[var_0]))
      var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
    else {
      if(!isDefined(self.botoperatorteam))
        self.botoperatorteam = scripts\engine\utility::random(var_7);

      if(getdvarint("_encstr_93B11F3027DA4E796A4F20B32762A1D0358FA8D99F75833132F523423E0BE3F896", 0) == 1) {
        logprint("_encstr_ADCF130660087B2A71C6A1B2222236E6498111099A" + self.name);
        logprint("_encstr_8F7113C6B1D22BDC8E39D5B5804040100408809E02" + var_4);
        logprint("_encstr_82DC134EC728A857552EDBA108B3B7481FBF2F56AA" + self.botoperatorteam);
        logprint("_encstr_AA361347C92BB2B70DD06369F96CEA7E82D1808D81" + var_5);
      }

      if(isDefined(level.playercustomizationdata[var_4][self.botoperatorteam]))
        var_5 = level.playercustomizationdata[var_4][self.botoperatorteam].operatorref;
    }
  }

  if(isai(self) || !isDefined(var_5) || var_5 == "_encstr_B40101") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[var_4][var_0].operatorref))
          var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
        else
          var_5 = self.botoperatorref;
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var_7 = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(var_7);
          }
        }

        var_0 = self.botoperatorteam;
        var_3 = undefined;

        if(!isDefined(self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"])) {
          if(getdvarint("_encstr_9B4F1A43F7A0E1A3880B7A0215D0A3AE207FDCD7139070872D2DB2BA", 1) == 1) {
            var_3 = randomint(level.operatorcustomization[var_0].size);
            self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"] = var_3;
          } else {
            var_13 = 0;

            foreach(var_16, var_15 in level.operatorcustomization[var_0]) {
              if(issubstr(var_16, "_encstr_8B1608EC43B8D647A113")) {
                var_3 = var_13;
                self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"] = var_13;
                self.botoperatorref = var_16;
                var_5 = var_16;
                break;
              }

              var_13++;
            }
          }
        } else
          var_3 = self.pers["_encstr_A6F90E52F82BB35FBBBD138318D1C5F3"];

        if(!isDefined(self.botoperatorref)) {
          var_13 = 0;

          foreach(var_16, var_15 in level.operatorcustomization[var_0]) {
            if(var_13 == var_3) {
              self.botoperatorref = var_16;
              var_5 = var_16;
              break;
            }

            var_13++;
          }
        }
      }
    } else
      var_5 = "_encstr_81A10E47316A2385D183BD4E35859620";
  }

  return var_5;
}

lookupcurrentoperatorskin(var_0) {
  var_1 = lookupcurrentoperator(var_0);
  var_2 = undefined;
  var_3 = self getentitynumber();

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && var_0 == "_encstr_8E8405EA382B2A") {
    var_4 = spawnStruct();
    var_4.operatorref = "_encstr_8B1B10E7D8E125229366B137C767CBFDEBC0";
    level.playercustomizationdata[var_3][var_0] = var_4;
    self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"] = 218;
    var_2 = 218;
  } else {
    if(getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt()) {
      if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
        if(!isDefined(level.showing_bomb_wire_pair_to_player))
          thermite_doradiusdamage();

        var_5 = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"];
        level.playercustomizationdata[var_3][var_0].operatorskinindex = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A18C08D8F67B1D52116E"][var_5];
        level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] = level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] + 1;

        if(level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] >= level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A39D0918EEC0F188825F21"])
          level.showing_bomb_wire_pair_to_player[var_1]["_encstr_A25B092863AAABF0D32D73"] = 0;
      }
    } else if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
      if(isai(self)) {
        if(!isDefined(self.botskinid))
          debug_interaction_toggle(var_1);

        level.playercustomizationdata[var_3][var_0].operatorskinindex = self.botskinid;
      } else
        level.playercustomizationdata[var_3][var_0].operatorskinindex = restart_watcher(var_1);
    }

    var_2 = level.playercustomizationdata[var_3][var_0].operatorskinindex;

    if(isai(self) && (!isDefined(var_2) || var_2 == 0) || !isDefined(var_2) || var_2 == 0) {
      if(isai(self)) {
        if(isDefined(self.botskinid))
          var_2 = self.botskinid;
        else
          debug_interaction_toggle(var_1);
      } else
        var_2 = 1;
    }
  }

  return var_2;
}

debug_interaction_toggle(var_0) {
  var_1 = self.team;

  if(isDefined(self.botoperatorteam))
    var_1 = self.botoperatorteam;

  if(!isDefined(self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"])) {
    var_2 = randomint(level.operatorcustomization[var_1][var_0].size);
    self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"] = var_2;
  } else
    var_2 = self.pers["_encstr_8EC2122F713DABE92090EABA08103ED037E18FEB"];

  var_3 = 0;

  foreach(var_8, var_5 in level.operatorcustomization[var_1][var_0]) {
    if(var_3 == var_2) {
      var_6 = int(tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 1, var_8, 0));
      self.botskinid = var_6;
      var_7 = var_6;
      break;
    }

    var_3++;
  }
}

picklaunchchunkoperatorskin(var_0) {
  if(!isDefined(level.launchchunkskins)) {
    level.launchchunkskins = [];
    level.launchchunkskins["_encstr_9A8507BA4040188D08"] = 0;
    level.launchchunkskins["_encstr_8E8405EA382B2A"] = 0;
  }

  if(!isDefined(self.launchchunkcustomizationindex)) {
    if(level.launchchunkskins[var_0] == 2)
      level.launchchunkskins[var_0] = 0;

    self.launchchunkcustomizationindex = level.launchchunkskins[var_0];
    level.launchchunkskins[var_0]++;
  }

  return self.launchchunkcustomizationindex;
}

getoperatorcustomization() {
  var_0 = lookupcurrentoperator(self.team);
  var_1 = lookupcurrentoperatorskin(self.team);

  if(isDefined(level._id_11C6A))
    [var_0, var_1] = [[level._id_11C6A]](self, var_0, var_1);

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    initlaunchchunkoperatorskins();

    if(!isDefined(self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]))
      self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"] = picklaunchchunkoperatorskin(self.team);

    var_3 = level.defaultoperatorskins[self.team]["_encstr_AD9B0589ED9197"][self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]];
    var_4 = level.defaultoperatorskins[self.team]["_encstr_81CC0586952C91"][self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]];
    var_5 = level.defaultoperatorskins[self.team]["_encstr_8419056EBAB41D"][0];
    var_6 = [];
    var_6[0] = var_3;
    var_6[1] = var_4;
    var_6[2] = var_5;
    return var_6;
  }

  if((var_0 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65" || var_0 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B") && (var_1 == 274 || var_1 == 275)) {
    initdefaultoperatorskins();
    var_7 = level.teambased && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB";

    if(!isDefined(self.defaultoperatorteam) || var_7 && self.defaultoperatorteam != self.team && (self.team == "_encstr_9A8507BA4040188D08" || self.team == "_encstr_8E8405EA382B2A")) {
      self.defaultoperatorteam = self.team;

      if(self.team != "_encstr_9A8507BA4040188D08" && self.team != "_encstr_8E8405EA382B2A")
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
    }

    if(!isDefined(self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"]))
      self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"] = 0;

    var_8 = self.defaultoperatorteam;
    var_9 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";

    if(var_9) {
      if(var_0 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65")
        var_8 = "_encstr_9A8507BA4040188D08";
      else
        var_8 = "_encstr_8E8405EA382B2A";
    }

    var_10 = self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"];
    var_3 = level.defaultoperatorskins[var_8]["_encstr_AD9B0589ED9197"][var_10];
    var_11 = level.defaultoperatorskins[var_8]["_encstr_81CC0586952C91"][var_10];

    if(!isDefined(self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"]))
      self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"] = randomint(var_11.size);

    var_12 = self.pers["_encstr_87D41923CA6616571B1DE9839539C28EDEE484590B19529B462B87"];

    if(var_12 >= var_11.size)
      var_12 = 0;

    var_4 = var_11[var_12];
    var_5 = "_encstr_863B129B97CFE0C82D04EB862DF0712C33372939";
  } else {
    var_3 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 4);
    var_4 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 5);
    var_5 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 19);
  }

  self.bodymodelname = var_3;
  self.backuphead = var_4;
  self.backupsuit = var_5;
  var_6 = [];
  var_6[0] = var_3;
  var_6[1] = var_4;
  var_6[2] = var_5;
  return var_6;
}

initlaunchchunkoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"] = [];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_9A7C2B4CDE235EF5DAC1FADD2BE63AB293CDD7335AE49547CA165BF5DD59E6D1D7325B27EBC4EB62AFD8B79198", "_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"] = ["_encstr_958F26A159C232D7B51CBEEE2BB9D195C973D7999627561D560BB57DEE95DC47D7196B9CEB64FA62", "_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF"];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_8419056EBAB41D"] = ["_encstr_863B129B97CFE0C82D04EB862DF0712C33372939"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"] = [];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_9A3126886A87534E1FC0180DA91F53236AE2E910A2DA93E317F91968857F7BD9997A18510A35D913", "_encstr_9932279DE71AE39905729ED1DEE33815937B6F2D5723A588250EC06EC7D948D5F99B93A7F76A78D029"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"] = ["_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA", "_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_8419056EBAB41D"] = ["_encstr_863B129B97CFE0C82D04EB862DF0712C33372939"];
}

initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["_encstr_9A8507BA4040188D08"] = [];
  level.defaultoperatorskins["_encstr_8E8405EA382B2A"] = [];

  switch (game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"]) {
    case "_encstr_8A65065739262C37":
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042", "_encstr_95262B26B752B8BF803331575D2ADB5F5A5E3FC5BB33BDA4B937F9A940CF427019C22D322F7EA0CBEF19D0B55B", "_encstr_9A7C2B4CDE235EF5DAC1FADD2BE63AB293CDD7335AE49547CA165BF5DD59E6D1D7325B27EBC4EB62AFD8B79198", "_encstr_81AC2B6AB089E72923701993F037DB2FE3A8CFE6DB13DF2BEB0B2229786352A3BE01759F7893EF22F7400A9222", "_encstr_91E02ACEE0C52BE7AFE3FE1BD7C389833B884F8D68F875E3FF83DDA7DB81372B60A77FA1BF8FB7E660D00149"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][0] = ["_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_9A5F25A4F1AB408942B079FC7D83331A36E55FCC10509513A217D9BF3347D3B9C9B10A485B5962"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][1] = ["_encstr_AF192683EBAF5A477803D12359709482FE65D7035B4E32241009552133E8DBCBC0B7878F4F5759B9", "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][2] = ["_encstr_828F26F8AF99D850D2CBAFF7B71B0D6822C586B1D4D298FD8A77D39FE702D628F7DF484BF1799117", "_encstr_958F26A159C232D7B51CBEEE2BB9D195C973D7999627561D560BB57DEE95DC47D7196B9CEB64FA62"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][3] = ["_encstr_81252698DBD087891D5BE9EB45EB5DD03D5A39CA135B822CCF63281F309043F410C0704707CB9957", "_encstr_9B25263219072B69A8298FAF2B70EB9736D0D95A6066E79BB073A5BF1738F29BC80872B20E1E5702"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][4] = ["_encstr_84522581C74265A10D7A869B27FB302D8B0377154FDBBD805D16C8964BD550DDF1EF8FDF46515F", "_encstr_9B522558FB382F47894BB923F1DEA3271845F7DE1B48B7D3A50192A99B3D67DB19E7471F0579EA"];
      break;
    case "_encstr_837707192BE62BE4E8":
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_87DB2A5A6FF26A1759DA7F675A5315FB6B6AC127E1ED8758793851F15C5A931B275A2A59B7EEDEE7C0D2F782", "_encstr_99522B86F03861E1B9E97F273B5E9BB55078710FA8E0050B85E3BF8F370D93FC912375D70642F7A7F0E1AF7BA3", "_encstr_AFF82BF238E53F098809AF8FCB900BB716F0B93A404607BB9013855FF71892BB282912C3EEBF37E269618F6C53", "_encstr_87FE2BB052BF5B4607C8107CB5176B3B62EAE118AAD2ABFB1FC101609F9773D181B2F88821BAA77B1FE418E531", "_encstr_BAF82AC47B4697F5B538FADD56E6D19593B9AFCC5AE456A395166B7D772BE6A3BE6E3BFA137D23AF1BBD9126"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][0] = ["_encstr_A75F25A3FD1F111FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9974B", "_encstr_A55F25B0A2AE3116B778A0AC45E7BB8BD2BA91481A027B4B4F91B1B04FC7036171D270F907910D"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][1] = ["_encstr_A9192611A5E6981807AB4E73C2474558FA36F7F5418A28D54FD2AD7E0BF7FE88D9830B7FCF22B13E", "_encstr_AD1926085F6928A0C2DB9FC7A70B7D7812F59641C4C2E8EDBA87C38F9732C638E70A58F9E16A8186"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][2] = ["_encstr_BD8F26C46D23A2B7407087DF207B547ADD7081FFC36DCAC469D0477798912B332F9D9572A053A14A", "_encstr_B48F268C3998F479316107AFA3E6132DA8E0C997D078BD831D5B3717BF852B741949FD1A8ED27FDF"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][3] = ["_encstr_AD25263ABA7FBB295BD3D1C3359FA1C2C39A91931BC86113174232B70F8587EB01D0787CDFEB9F45", "_encstr_8625260D6F17DCBFEA88B19B450BBB4DEE8D998BCB2D85C352B265A19CA20FDB98C9A54FC98A6F12"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][4] = ["_encstr_B652250C39D6B24919409FB3ED06F39DC3B288754463BA7319AFDDCF776DB2938F2ACF47EF6F7B", "_encstr_8652251227682C9780830E934A2F3817F86DE1DA93E8A235E25F4D1113277B9B7F678FCEDA4942"];
      break;
    case "_encstr_924D09EBE0478F23A1B0E4":
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_BE3D2AF55F37E088971BFEE35237D5C84AA60765F11A5865DF22B0EE9B470E38A901A59F31092238C3BAA9DB", "_encstr_99B92B5AE718603FF143A12BC9D6ABDF937DEFA60370AFDBAD199A9193257FD311EF452FD702791E5890B22AB3", "_encstr_83662B930874631888FF31B7A5A641D233E06F474182118D779FB2DEFFEB5388AF9A07FA7733697FF1191FFDDB", "_encstr_91D42BE897473B0F05735073AADFF9133210A989A39B9783B57B681980054063D010897F3F5EAF5E6788E82992", "_encstr_BD532A3E10613BEF1838BF17F8B39CA2E538C9B78BB5320C21A80FAF50A9537BE7CE4F614F472F1FE8F0231E"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][0] = ["_encstr_A15F25035DBFB1FF1D4BA9E032B291295BCEAF8CB92B59E1472220990BCF574397691EE859F7CB", "_encstr_8D5F2586AC5832EBB607D7BBB26E8ECA9CB9FACC4B272BA35616DAFA7759E68EEB58C9FA64AF99"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][1] = ["_encstr_8C192643C8C98C192BCF29DBBDFF6355733827F330C3C5F3036FADD99C8B6B0C7E28676FE913074F", "_encstr_971926EB35D2A25950BB11601B5FDD9B4585BFEDE42DCDCBF301C071A81DA8BBAF2BBD1F604FBFDB"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][2] = ["_encstr_878F264B2357A2BFB0DB191B1128DCCAB65D0FFB83067A6C28C18D694BA0031398D14F13070F8163", "_encstr_B68F261A560BC8F5DA07AFDD566ED12B2773AF33A593CAA395C2B5EBEE56CD8E7D91DA4EEB8CFACC"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][3] = ["_encstr_972526882BE8FF9759FB0973A1AEF377A895070EAB18C76375F122F9CB8D976B6969BD97AFBA81B6", "_encstr_8B2526D08781C0483A3347EF9F23252B4ADDBEA92CFAB095925F2BB7FF6AEED0CFB56001D902A9EE"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][4] = ["_encstr_A65225E95D6E10809F23F6FB5ACFCDC042BE7F7DC912505DC72A88E6834F06A3511B879739315A", "_encstr_8B522586CA1646BEB607F5EEB26E8E59E4CDAF33A59C591DAC0B5B7DBBB26E3AD737B3EB19EB66"];
      break;
    default:
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_AD9B0589ED9197"] = ["_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042", "_encstr_95262B26B752B8BF803331575D2ADB5F5A5E3FC5BB33BDA4B937F9A940CF427019C22D322F7EA0CBEF19D0B55B", "_encstr_9A7C2B4CDE235EF5DAC1FADD2BE63AB293CDD7335AE49547CA165BF5DD59E6D1D7325B27EBC4EB62AFD8B79198", "_encstr_81AC2B6AB089E72923701993F037DB2FE3A8CFE6DB13DF2BEB0B2229786352A3BE01759F7893EF22F7400A9222", "_encstr_91E02ACEE0C52BE7AFE3FE1BD7C389833B884F8D68F875E3FF83DDA7DB81372B60A77FA1BF8FB7E660D00149"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][0] = ["_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_9A5F25A4F1AB408942B079FC7D83331A36E55FCC10509513A217D9BF3347D3B9C9B10A485B5962"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][1] = ["_encstr_AF192683EBAF5A477803D12359709482FE65D7035B4E32241009552133E8DBCBC0B7878F4F5759B9", "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][2] = ["_encstr_828F26F8AF99D850D2CBAFF7B71B0D6822C586B1D4D298FD8A77D39FE702D628F7DF484BF1799117", "_encstr_958F26A159C232D7B51CBEEE2BB9D195C973D7999627561D560BB57DEE95DC47D7196B9CEB64FA62"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][3] = ["_encstr_81252698DBD087891D5BE9EB45EB5DD03D5A39CA135B822CCF63281F309043F410C0704707CB9957", "_encstr_9B25263219072B69A8298FAF2B70EB9736D0D95A6066E79BB073A5BF1738F29BC80872B20E1E5702"];
      level.defaultoperatorskins["_encstr_9A8507BA4040188D08"]["_encstr_81CC0586952C91"][4] = ["_encstr_84522581C74265A10D7A869B27FB302D8B0377154FDBBD805D16C8964BD550DDF1EF8FDF46515F", "_encstr_9B522558FB382F47894BB923F1DEA3271845F7DE1B48B7D3A50192A99B3D67DB19E7471F0579EA"];
  }

  switch (game["_encstr_AF030C58B33923F7B2630D1C7C5B"]) {
    case "_encstr_8A65065739262C37":
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_9A3126886A87534E1FC0180DA91F53236AE2E910A2DA93E317F91968857F7BD9997A18510A35D913", "_encstr_8874272A9768102FE153913A59C65BCF306D9FB633605FCB9D698A8121170FC301FF553FC7F865739F", "_encstr_850327137B235EBE6BC1AFB216CDA32B4E73BE335AC9ACA3CA58ADFACA0BDCA3EB19DAC9BEB1BD8C4C", "_encstr_9932279DE71AE39905729ED1DEE33815937B6F2D5723A588250EC06EC7D948D5F99B93A7F76A78D029", "_encstr_8B2A2658BA57A3BEEF10C8DD194F03533A5239E0726AC393A729E9D8F52FAB09292B3BA1BA4509C3"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][0] = ["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103", "_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA", "_encstr_AFB023862B2C8CBEDAE0FAB20BCDD1CA39E6EB99B49CB2D1CA85D6AFAC0BB9D1F55827F566", "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][1] = ["_encstr_A7042418FD5BBB57D25B09E880C7EB0D6D1E17CAAA823F890D3F3FC1452F17E5D78E6D47B7B1", "_encstr_9B042463FD20DC21ED8B56F7E37BD0A2AA630F69F38BEF88B86769719279E3D391C657472992", "_encstr_9904241047412388FAF3878BCF6365400A1D7E69ECBAF0D5529FEBF7F76A2E108F32A0C19943"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][2] = ["_encstr_8C20225CF58B0A0FF8D81FFF7813FCC2459869576B15526C8148EF0FA089B39B47256DCA"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][3] = ["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][4] = ["_encstr_8FBA218AA1BF83C170C17755FBD853CF5EB871F2888E5FC3D8CB4D679B605A7310B38A"];
      break;
    case "_encstr_837707192BE62BE4E8":
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_BD6E286AA07DB78130813715BB18930F9E7831B2C8CE9F03188B0D275BA01A3350311BA93B30733D2853", "_encstr_884B2931DBC8F27DADC1D7CA0B37D1CAC937F566D2C92BE8560BB5D795C2CDA3FA9BB5D9D78CAFD8B78C98", "_encstr_A51129B12564C8A8DAD3A7EBAF0305602AFD9E49CCDA90F5B27FCB97D74ACE30EFD74043F96289A14A736B", "_encstr_A76F2913DB46BCAFB607FA951637D19527B97D66D227CA1DCA85D6AF56C26E8EEB63B63B7DC8D736BD2398", "_encstr_968C2889ED915EBEAD1CAF59163747594E37BECCA527561D56B06B7DB22C9B3ABECD76EB46D71BDB32C4"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][0] = ["_encstr_A6402530672160E89A93E7ABEF4345A0EA3D5E098C9AD03572BF8BD7178A0E70AF5663A622CF22", "_encstr_A94025432B0B23BEB51C7D5916B9475939E6EB334BE42BE895856BBEB2B0CD8EAFB04EF546FA8C", "_encstr_BD40250DCAB0197DDA0EEB95B09B3A95E4B9D733B4C9564795C26BF5560B9BD1BEC2C9AF66EB91", "_encstr_923F25A1153648C8D75BBEE152F715088A664725B15A98A51F62F0AE7A974E7869C165DF74C96A"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][1] = ["_encstr_BA1F263C892844E9A1F177973B56A3BD58707907A0E80D138DEBA7872B779BE4893B6DCF1E5AEFAF", "_encstr_B21F26342B85C8AF5B0EF5CAB0DCE85693CD7DCCA5C956A356C2DAF5AC85DC3AAFCDAD9D7D46FA91", "_encstr_821F267380E7646187CFF1D2C99BCB1D15DEE1D5B3589B088F02F91941781E810F37B30FE7C6D6BB"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][2] = ["_encstr_8C20225CF58B0A0FF8D81FFF7813FCC2459869576B15526C8148EF0FA089B39B47256DCA"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][3] = ["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][4] = ["_encstr_8FBA218AA1BF83C170C17755FBD853CF5EB871F2888E5FC3D8CB4D679B605A7310B38A"];
      break;
    case "_encstr_924D09EBE0478F23A1B0E4":
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_B29028EAA8B22B4982871F11F3AB7B7F16B509BBA99DAF83CA834031780BFBEB79AA4E8E73BF8D0F0751", "_encstr_A142298E65FA4B5EDD6B59B017FBF3BB43CDE8047C33CB63BD47C069EF012BC1F932791C595FF7A86F4B3A", "_encstr_BA8529B6B745636F7A83A1CBA9EB343513CE7F9BB335D738155162A91B226A0340A9D80DF90F1F60BFA1C2", "_encstr_9301292BD829D1596B8F699F7F3FA395B37867B370030533432FED1955C32B4CBE10272F299347FABFB5E2", "_encstr_96F72883D735935F90FB39BFF148BCEA967DEF1BA3661A4C0821AD0969A0E333F8DF8787BF18521F6803"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][0] = ["_encstr_B640255B377AA18E0D9BA960C74BA3EB339D58D48CE37B13EDF730B9BF719B3149C646F072E99F", "_encstr_BA402578BD219BD1DB7801BAE83FD357FB90C7EEC32BC723E3182A11E0734AABB68F525FC65656", "_encstr_874025A1153648C8D75BBEE152F715088A664725B15A98A51F62F0AE7A974E7869C165DF73C962", "_encstr_BE3F25E155760888971BFEA11237D5C84AA60765F11A5865DF22B0EEBA570E38A901A59F340922"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][1] = ["_encstr_A91F26C017E1F1C7A272C8ED0E7BA9995AA3F1C84FAA6959CADED9F86732EF638F7FF8482F01E68F", "_encstr_841F2634B22C19BEB507D7562CDC1D2B27E6F59996E4B21D56166BEBAC58DCA3F5B9DACE7D8CBECC", "_encstr_BD1F26A1ACC246BE6B1CD7AC8537E895E4DC7D334BC9568E95C2B57D59589BD1F5DCADD9EBCCD799"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][2] = ["_encstr_8C20225CF58B0A0FF8D81FFF7813FCC2459869576B15526C8148EF0FA089B39B47256DCA"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][3] = ["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][4] = ["_encstr_8FBA218AA1BF83C170C17755FBD853CF5EB871F2888E5FC3D8CB4D679B605A7310B38A"];
      break;
    default:
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_AD9B0589ED9197"] = ["_encstr_9A3126886A87534E1FC0180DA91F53236AE2E910A2DA93E317F91968857F7BD9997A18510A35D913", "_encstr_8874272A9768102FE153913A59C65BCF306D9FB633605FCB9D698A8121170FC301FF553FC7F865739F", "_encstr_850327137B235EBE6BC1AFB216CDA32B4E73BE335AC9ACA3CA58ADFACA0BDCA3EB19DAC9BEB1BD8C4C", "_encstr_9932279DE71AE39905729ED1DEE33815937B6F2D5723A588250EC06EC7D948D5F99B93A7F76A78D029", "_encstr_8B2A2658BA57A3BEEF10C8DD194F03533A5239E0726AC393A729E9D8F52FAB09292B3BA1BA4509C3"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][0] = ["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103", "_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA", "_encstr_AFB023862B2C8CBEDAE0FAB20BCDD1CA39E6EB99B49CB2D1CA85D6AFAC0BB9D1F55827F566", "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][1] = ["_encstr_A7042418FD5BBB57D25B09E880C7EB0D6D1E17CAAA823F890D3F3FC1452F17E5D78E6D47B7B1", "_encstr_9B042463FD20DC21ED8B56F7E37BD0A2AA630F69F38BEF88B86769719279E3D391C657472992", "_encstr_9904241047412388FAF3878BCF6365400A1D7E69ECBAF0D5529FEBF7F76A2E108F32A0C19943"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][2] = ["_encstr_8C20225CF58B0A0FF8D81FFF7813FCC2459869576B15526C8148EF0FA089B39B47256DCA"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][3] = ["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"];
      level.defaultoperatorskins["_encstr_8E8405EA382B2A"]["_encstr_81CC0586952C91"][4] = ["_encstr_8FBA218AA1BF83C170C17755FBD853CF5EB871F2888E5FC3D8CB4D679B605A7310B38A"];
  }
}

pickdefaultoperatorskin(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_2 = scripts\mp\utility\weapon::getweapongroup(var_0);

    switch (var_2) {
      case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
      case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
        var_1 = 0;
        break;
      case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        var_1 = 1;
        break;
      case "_encstr_A1710B57AD31DBCDCDF1422A60":
      case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
        var_1 = 2;
        break;
      case "_encstr_A3710BEEACC2E0B737EB36B676":
        var_1 = 3;
        break;
      case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        var_1 = 4;
        break;
      default:
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

getglcustomization() {
  var_0 = self.primaryweapon;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self.loadoutequipmentprimary;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "_encstr_AB960DC007AFE8A837F8D5C8C0732B")
    var_5 = "_encstr_83530768429A7B2CBB";
  else
    var_5 = "_encstr_B40101";

  switch (self.team) {
    case "_encstr_9A8507BA4040188D08":
      var_6 = "_encstr_83E4056B4F5236";

      if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        var_7 = "_encstr_9B4406CFFBA256AC";
      else
        var_7 = "_encstr_B40101";

      switch (var_1) {
        case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        case "_encstr_AF710BF4355A9195B0FF0AEAD0":
          var_3 = "_encstr_8A430599F6804B";
          var_4 = "_encstr_8A430599F6804B";
          break;
        case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
        case "_encstr_A3710BEEACC2E0B737EB36B676":
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_974305B1E80807";
          break;
        case "_encstr_A1710B57AD31DBCDCDF1422A60":
        case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
          var_3 = "_encstr_8A430599F6804B";
          var_4 = "_encstr_8A430599F6804B";
          break;
        default:
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
      }

      break;
    case "_encstr_8E8405EA382B2A":
      var_6 = "_encstr_9AE30B97DF8F73B04AA34B18FB";
      var_7 = "_encstr_B40101";

      switch (var_1) {
        case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        case "_encstr_AF710BF4355A9195B0FF0AEAD0":
          var_3 = "_encstr_8A430599F6804B";
          var_4 = "_encstr_8A430599F6804B";
          break;
        case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
        case "_encstr_A3710BEEACC2E0B737EB36B676":
          var_3 = "_encstr_974305B1E80807";
          var_4 = "_encstr_974305B1E80807";
          break;
        case "_encstr_A1710B57AD31DBCDCDF1422A60":
        case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
        default:
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
      }

      break;
    default:
      var_6 = "_encstr_83E4056B4F5236";
      var_7 = "_encstr_B40101";
      var_3 = "_encstr_B21A04BEC29C";
      var_4 = "_encstr_B21A04BEC29C";
      break;
  }

  var_8 = "_encstr_8AB20628CA27B3AE" + var_6 + var_3 + var_7;
  var_9 = "_encstr_95460650424ED1F6" + var_6 + var_4 + var_5;
  self.backuphead = "_encstr_95460650424ED1F6" + var_6 + var_4;
  self.bodymodelname = "_encstr_8AB20628CA27B3AE" + var_6 + var_3;
  var_10 = [];
  var_10[0] = var_8;
  var_10[1] = var_9;
  return var_10;
}

getglcustomizationhackney() {
  var_0 = self.primaryweapon;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self.loadoutequipmentprimary;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "_encstr_AB960DC007AFE8A837F8D5C8C0732B")
    var_5 = "_encstr_83530768429A7B2CBB";
  else
    var_5 = "_encstr_B40101";

  switch (self.team) {
    case "_encstr_9A8507BA4040188D08":
      var_6 = "_encstr_8FDB0AC8C033617D53B6780D";

      if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        var_7 = "_encstr_B40101";
      else
        var_7 = "_encstr_B25C0641DB7A020D";

      switch (var_1) {
        case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        case "_encstr_AF710BF4355A9195B0FF0AEAD0":
          var_3 = "_encstr_8A430599F6804B";
          var_4 = "_encstr_AB1008D7B6E0FA36C56C";
          break;
        case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
        case "_encstr_A3710BEEACC2E0B737EB36B676":
          var_3 = "_encstr_974305B1E80807";
          var_4 = "_encstr_974305B1E80807";
          break;
        case "_encstr_A1710B57AD31DBCDCDF1422A60":
        case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
          var_3 = "_encstr_A24305AF91B593";
          var_4 = "_encstr_A3100869CBC88138E842";
          break;
        default:
          var_3 = "_encstr_B21A04BEC29C";
          var_4 = "_encstr_B21A04BEC29C";
          break;
      }

      break;
    case "_encstr_8E8405EA382B2A":
      var_6 = "_encstr_9A240AC263F5172C1D2CC658";
      var_7 = "_encstr_B40101";

      switch (var_1) {
        case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        case "_encstr_A3710BEEACC2E0B737EB36B676":
        case "_encstr_A1710B57AD31DBCDCDF1422A60":
        case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
        case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
        case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
          var_3 = "_encstr_A28C06FA62D785C9";
          var_4 = "_encstr_B21A04BEC29C";
          break;
        default:
          var_3 = "_encstr_A28C06FA62D785C9";
          var_4 = "_encstr_B21A04BEC29C";
          break;
      }

      break;
    default:
      var_6 = "_encstr_83E4056B4F5236";
      var_7 = "_encstr_B40101";
      var_3 = "_encstr_B21A04BEC29C";
      var_4 = "_encstr_B21A04BEC29C";
      break;
  }

  var_8 = "_encstr_8AB20628CA27B3AE" + var_6 + var_3 + var_7;
  var_9 = "_encstr_95460650424ED1F6" + var_6 + var_4 + var_7;
  self.backuphead = "_encstr_95460650424ED1F6" + var_6 + var_4;
  self.bodymodelname = "_encstr_8AB20628CA27B3AE" + var_6 + var_3;
  var_10 = [];
  var_10[0] = var_8;
  var_10[1] = var_9;
  return var_10;
}

forcedefaultmodel() {
  if(self.team == "_encstr_8E8405EA382B2A") {
    self setModel("_encstr_83DA1203A801E0757B02F158EA4738C827118DA3");
    self setviewmodel("_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707");
  } else {
    self setModel("_encstr_825A13B8136F3E701F7947238647F8766BFA11666A");
    self setviewmodel("_encstr_A78D16CEA5ACBB5BF619ACC67DD6077D4C58CD59BE5A7707");
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "_encstr_B40101");
    self.headmodel = undefined;
  }

  self attach("_encstr_BE0811E44DC34257A090678758F9257AB1D56F", "_encstr_B40101", 1);
  self.headmodel = "_encstr_BE0811E44DC34257A090678758F9257AB1D56F";
  self setclothtype("_encstr_A99506D77CD5A833");
}

watchafk() {
  if(getdvarint("_encstr_955E13729906EFE7B9AF24378161E7AF2E90FA8AA0", 0) == 1) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 0;

  for(;;) {
    var_0++;

    if(var_0 >= level.players.size)
      var_0 = 0;

    if(isDefined(level.players[var_0])) {
      if(isai(level.players[var_0])) {
        waitframe();
        continue;
      }

      level.players[var_0] checkforafk();
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

checkforafk() {
  if(istrue(level.gameended) || !istrue(self.hasspawned)) {
    return;
  }
  var_0 = 0;
  var_1 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);
  var_1 = int(max(var_1 - self.timeplayed["_encstr_8E6E097D1C928BB55DB708"], 0));

  if(istrue(self.elevator_manager)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258") {
      return;
    }
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      return;
    }
    if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_85EE090C9DD0A62F3CA1B3") {
      if(isDefined(self.vehicle) && self.vehicle.vehiclename == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
        var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self.vehicle, "_encstr_8D48079DD59BE65627");

        if(isDefined(var_2) && var_2 == self)
          return;
      }
    }

    if(istrue(self.txt_nag)) {
      return;
    }
    var_1 = var_1 - self.timeplayed["_encstr_9B220634456A5747"];
    var_1 = var_1 - self.timeplayed["_encstr_82D10F60A26E2BB3D36026A553EB19AFD5"];
  }

  if(istrue(self.shoulddeleteimmediately)) {
    return;
  }
  if(!isDefined(self.timeplayedonfirstspawn)) {
    return;
  }
  var_3 = self.timeplayedonfirstspawn;
  var_4 = self.pers["_encstr_8E8D0697EB01F243"];
  var_5 = self.pers["_encstr_A1F308589BCD96CD476E"];
  var_6 = self.pers["_encstr_A9AB06297DDFD816"];
  var_7 = var_4 == 0 && var_5 == 0 && (!isDefined(var_6) || isDefined(var_6) && var_6 == 0);
  var_8 = isDefined(self.lastdamagetime) && self.lastdamagetime + 60000 > gettime();
  var_9 = var_1 - var_3;
  var_9 = var_9 - self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"];
  var_10 = 60;

  if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916")
    var_10 = 15;

  var_11 = getdvarfloat("_encstr_8AA818371B27EBB0CCD688D29BD115A5DA593D67B29393D28CAC", 0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && istrue(self.display_hint_for_player_single)) {
    self.display_hint_for_player_single = undefined;
    var_10 = 30;
  } else if(var_11 > 0)
    var_10 = var_11;

  if(scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::getgametype() != "_encstr_8E1904B3F501") {
    var_12 = var_7 || level.gametype == "_encstr_A9B606B0C956B916";

    if(level.gametype != "_encstr_A9B606B0C956B916") {
      if(var_7 && var_9 > 120) {
        if(!var_8) {
          switch (level.gametype) {
            case "_encstr_8A1804DAAB75":
              if(istrue(level.kick_afk_check))
                var_0 = 1;

              break;
          }
        }
      }
    }

    if(var_12 && !isDefined(self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"]) && var_9 >= var_10) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163") {
        if(self.team == "_encstr_8E8405EA382B2A")
          var_0 = 1;
      } else if(!isDefined(self.laststancechangetime) || gettime() - self.laststancechangetime > 11000)
        var_0 = 1;
    }

    if(!isDefined(self.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"]))
      self.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"] = 0;

    if(var_0 && !isgamebattlematch() && !istrue(self.binoculars_onstatemarkedexit)) {
      self.binoculars_onstatemarkedexit = 1;
      self.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"]++;

      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || self.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"] > 1)
        level thread vehomn_controlsarefadedoutorhidden(self);
    }

    return;
  } else {
    if(var_7 && !var_8 && var_9 >= var_10) {
      if(!isDefined(self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"])) {
        if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163") {
          if(self.team == "_encstr_8E8405EA382B2A")
            var_0 = 1;
        } else
          var_0 = 1;
      }
    }

    if(var_7 && var_9 > 120) {
      if(!var_8) {
        switch (level.gametype) {
          case "_encstr_8A1804DAAB75":
            if(istrue(level.kick_afk_check))
              var_0 = 1;

            break;
        }
      }
    }
  }

  if(var_0 && !isgamebattlematch())
    level thread vehomn_controlsarefadedoutorhidden(self);
}

vehomn_controlsarefadedoutorhidden(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_81E51B2142D3C703901F1F15B093E3E65CA1DF4D362A5DA1A17DB31A94");
  wait 1;
  kick(var_0 getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3", 1);
}

getjointeampermissions(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = level.players;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5.pers["_encstr_8AEF05472BC2D6"]) && var_5.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      var_1++;

      if(isbot(var_5))
        var_2++;
    }
  }

  if(level.maxteamsize == 0 || var_1 < level.maxteamsize)
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_951904D8F1E0" && istrue(isagent(self)))
    return 1;
  else if(var_2 > 0)
    return 1;
  else if(!scripts\mp\utility\game::matchmakinggame())
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163")
    return 1;
  else if(scripts\mp\menus::brking_updateteamscore())
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52") || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    return 1;
  else {
    getentitylessscriptablearray("_encstr_B2BC1BC0AB797BBA37A575FDBD7306115F0248C9920E999607DA866082", ["_encstr_84E90C90A37122C32329CB55BC9A", self getxuid(), "_encstr_AC6B07202B50B7EAC9", self ishost()]);

    if(self ishost())
      wait 1.5;

    kick(self getentitynumber(), "_encstr_AF2A1DE7616520A80B6593D7162A4FCEFA57410E13183D3099E411C5A819F4");
    return 0;
  }
}

onplayerspawned() {
  if(!isDefined(self.timeplayedonfirstspawn))
    self.timeplayedonfirstspawn = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532");

  if(getdvarint("_encstr_8E5C12B9C64EFAD12B0B6BBEDBAB1D36D2E659DC", 0) == 1 && !scripts\mp\utility\game::runleanthreadmode()) {
    if(scripts\mp\utility\game::issquadmode())
      thread outlinesquad_apply();
    else
      thread outlinefriendly_apply();
  }
}

outlinefriendly_apply() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!level.teambased) {
    return;
  }
  if(getdvarint("_encstr_9B9916B307501153F6F88A0261C1E7D960C34C248B18275F", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }
  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
    level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_B45B130F8BC07DCF58D989928DA14779C81BBF8011", "_encstr_A1560DDBEA1D1B5A732BD72C8D63F2");
  var_1 = scripts\mp\utility\outline::outlineenableforteam(self, self.team, var_0, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  thread outlinefriendly_remove(var_1);
}

outlinefriendly_remove(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_81170C244F9CBDE72C01BB99A298");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

outlinesquad_apply() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(getdvarint("_encstr_8B39135AE910DF4BCF9BEFF3E7F8134C483095A783", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }
  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
    level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "_encstr_B2F614155BD37A3FCDEBC75B3BBB013DBFE6FB309993", "_encstr_84CA0E124809C57F187D97B30F03278F");
  var_1 = scripts\mp\utility\outline::outlineenableforsquad(self, self.team, self.squadindex, var_0, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  thread outlinesquad_remove(var_1);
}

outlinesquad_remove(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A6("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_84760DD4F696DCCA32D7B9C5AB5891");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

resetsuper(var_0) {
  var_1 = scripts\engine\utility::_encstr_A60611BAC359A32CD843EAFC53C07507727BE3(["_encstr_968317A04A15C3311D1833E2CDD030E923911E09E22EF99B35", "_encstr_B4C71B5B43763328F5CDF348F3CAD87D9B6F3DD18FD98E105AF5F9C35B"], 2, var_0, 3);

  if(!isDefined(var_1) || var_1 == "_encstr_B40101")
    var_1 = "_encstr_B21904D2EE0E";

  return var_1;
}

getoperatorexecution(var_0) {
  if(isDefined(self.executionref))
    self.loadoutexecution = self.executionref;
  else if(getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt() && level.gametype == "_encstr_B607038AAB") {
    var_1 = getarraykeys(level.execution.table);

    if(!isDefined(self._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3)) {
      if(!isDefined(level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3)) {
        var_2 = randomint(var_1.size);
        level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3 = var_2;
        level._encstr_B4E9175072A6CC4D199B372D40E0BFB3DB7F986A98EB9F8AA1 = [];
      } else {
        for(var_3 = 0; var_3 < var_1.size; var_3++) {
          var_4 = var_1[level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3];
          var_5 = level.execution.table[var_4];

          if(isDefined(var_5) && isDefined(var_5.propweapon) && !scripts\engine\utility::array_contains(level._encstr_B4E9175072A6CC4D199B372D40E0BFB3DB7F986A98EB9F8AA1, var_5.propweapon)) {
            level._encstr_B4E9175072A6CC4D199B372D40E0BFB3DB7F986A98EB9F8AA1[level._encstr_B4E9175072A6CC4D199B372D40E0BFB3DB7F986A98EB9F8AA1.size] = var_5.propweapon;
            break;
          }

          level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3++;

          if(level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3 >= var_1.size)
            level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3 = 0;
        }
      }

      self._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3 = level._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3;
    }

    var_4 = var_1[self._encstr_BE4A1734AC0B23B12B9B9B56C3598DEA3AB4EDCDA5CD32ACC3];
    self.loadoutexecution = var_4;
  } else {
    var_6 = 0;
    var_4 = "_encstr_B40101";

    if(!isagent(self))
      var_6 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_0, "_encstr_B1100A561EACC6AB3AB47BCD");

    if(var_6 > 0)
      var_4 = tablelookup("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", 0, var_6, 1);

    if(var_4 == "_encstr_B40101")
      var_4 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 24);

    self.loadoutexecution = var_4;
  }

  return self.loadoutexecution;
}

resetposition(var_0) {
  var_1 = 0;

  if(!isagent(self))
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8C2716AA53EDAB3EC8AF0AC36308831701E873F27BB3A7B5", var_0, "_encstr_AD2906FBFA7593E3");

  if(var_1 == 0) {
    var_2 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 23);
    self._id_1195C = tablelookup("_encstr_8887127B0759E42C8EBD4E17574B0EE6C5D89B3B", 1, var_2, 6);
  } else
    self._id_1195C = tablelookup("_encstr_8887127B0759E42C8EBD4E17574B0EE6C5D89B3B", 0, var_1, 6);

  return self._id_1195C;
}

resetscorefeedcontrolomnvar(var_0) {
  self._id_1195D = tablelookup("_encstr_83951975F9E1C6E3B081B36A29F58B3C085DE4C175A08F524E7B4B", 1, self.loadoutexecution, 19);
  return self._id_1195D;
}

getoperatorsuperfaction(var_0) {
  var_1 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 3);
  return int(var_1);
}

getoperatorvoice(var_0, var_1) {
  if(var_0 == "_encstr_A3A71019AC990BBA63D1EB95589B4756E49B" || var_0 == "_encstr_A34110553F02A3F33483B1F8AF43ABD32B65") {
    var_2 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_1, 24);

    if(isDefined(var_2) && var_2 != "_encstr_B40101")
      return var_2;
  }

  var_2 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 10);
  return var_2;
}

resettimeronpickup(var_0) {
  if(isstartstr(var_0, "_encstr_BD0703AF7C"))
    return "_encstr_BD0703AF7C";
  else if(isstartstr(var_0, "_encstr_AF0703BB78"))
    return "_encstr_AF0703BB78";

  return "_encstr_B21904D2EE0E";
}

resetplayermovespeedscale(var_0) {
  var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 22);
  return var_1;
}

getoperatorgender(var_0) {
  var_1 = scripts\engine\utility::ter_op(tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 11) == "_encstr_934C0218", "_encstr_A6A205ADB0632B", "_encstr_B82907C2887BC62B39");
  return var_1;
}

resetplayerdataforrespawningplayer(var_0) {
  var_1 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_0, 23);
  return var_1;
}

resetunresolvedcollision(var_0) {
  var_1 = tablelookup("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", 1, var_0, 31);
  return int(var_1);
}

update_timer_for_bomb_vest_detonator_holder(var_0) {
  var_1 = tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_0, 24);
  return isDefined(var_1) && var_1 == "_encstr_A34C02BB";
}

runbrgametypefunc6(var_0) {
  var_1 = 0;

  if(!isagent(self))
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");

  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 4);
  return var_2;
}

rundomplateskybeam(var_0) {
  var_1 = 0;

  if(!isagent(self))
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");

  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 5);
  return var_2;
}

runcircles(var_0, var_1) {
  var_2 = 0;

  if(!isagent(self))
    var_2 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_A9CC0534F64EB9");

  var_3 = tablelookup("_encstr_A5951722A33F9A5302F372F0873E4369EAB86BD02BD8FECF0B", 0, var_2, var_1);
  return var_3;
}

runcontrolledcallback(var_0) {
  var_1 = 0;

  if(!isagent(self))
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_845115BDC7D2E3400C3F05DBA2FCE8293A530B314F0A38", var_0, "_encstr_B19005D885B5F6");

  var_2 = tablelookup("_encstr_8FF31742192F982110E657483A7A91AFE2D15DDD1B8096CF43", 6, var_1, 10);
  return var_2;
}

initnightvisionheadoverrides() {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }
  level.nvgheadoverrides = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 5);
    var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 17);
    var_3 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_0, 16);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    if(var_2 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_87070365F7"] = var_2;

    if(var_3 != "_encstr_B40101")
      level.nvgheadoverrides[var_1]["_encstr_9767056D0FBFA8"] = var_3;

    var_0++;
  }

  level.nvgheadoverrides["_encstr_A5B0234CF95834B9F1A147A7EBA6536D682009579038FDC3DD9BF757DB47EBB459A9FA9103"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_A6402530672160E89A93E7ABEF4345A0EA3D5E098C9AD03572BF8BD7178A0E70AF5663A622CF22"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_B640255B377AA18E0D9BA960C74BA3EB339D58D48CE37B13EDF730B9BF719B3149C646F072E99F"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_9AB023F3AD4F416F8DDB19C0E222E1B9EB5E907C09BB2971F7D2B0095A7EA7D307F98E78CA"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_A94025432B0B23BEB51C7D5916B9475939E6EB334BE42BE895856BBEB2B0CD8EAFB04EF546FA8C"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_BA402578BD219BD1DB7801BAE83FD357FB90C7EEC32BC723E3182A11E0734AABB68F525FC65656"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
  level.nvgheadoverrides["_encstr_AC2022C89FA9E860021B5F2377CB3D3852B5D6810402A8ADFA47034F9F3286F8278D1839"]["_encstr_87070365F7"] = "_encstr_8BBA05185F8B99";
}

thermite_doradiusdamage() {
  if(isDefined(level.showing_bomb_wire_pair_to_player)) {
    return;
  }
  level.showing_bomb_wire_pair_to_player = [];
  var_0 = tablelookupgetnumrows("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 18) != "_encstr_B40101") {
      var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 2);
      var_3 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_1, 0);

      if(!isDefined(level.showing_bomb_wire_pair_to_player[var_2])) {
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"] = [];
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A25B092863AAABF0D32D73"] = 0;
        level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] = 0;
      }

      level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"][level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A18C08D8F67B1D52116E"].size] = int(var_3);
      level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] = level.showing_bomb_wire_pair_to_player[var_2]["_encstr_A39D0918EEC0F188825F21"] + 1;
    }
  }
}

initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }
  level.operatorcustomization = [];
  var_0 = getlocalestructarray();
  setDvar("_encstr_A7F7191B36BECD8E4EAC58D6D45EB936AF462BEC93B762C247C6D0", 1);
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_1, 1);
    var_3 = getoperatorsuperfaction(var_2);
    var_4 = scripts\engine\utility::ter_op(var_3 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_5 = int(tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_1, 8));
    var_6 = resetunresolvedcollision(var_2);
    var_7 = var_0 && update_track_operational_status(var_2);

    if(var_5 && var_6 && !var_7) {
      if(!isDefined(level.operatorcustomization[var_4]))
        level.operatorcustomization[var_4] = [];

      level.operatorcustomization[var_4][var_2] = [];
    }

    var_1++;
  }

  var_8 = 0;

  for(;;) {
    var_9 = int(tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_8, 20));
    var_10 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_8, 1);

    if(!isDefined(var_10) || var_10 == "_encstr_B40101") {
      break;
    }

    if(var_9) {
      var_2 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_8, 2);
      var_11 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_8, 4);
      var_12 = tablelookupbyrow("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", var_8, 5);
      var_4 = getoperatorteambyref(var_2);

      if(!isDefined(var_4)) {
        var_8++;
        continue;
      }

      var_13 = [];
      var_13[0] = var_11;
      var_13[1] = var_12;
      level.operatorcustomization[var_4][var_2][var_10] = var_13;
    }

    var_8++;
  }

  if(getdvarint("_encstr_85B326EA59A06F1A9DC7CBAFD34B538978E0653576E01153F6EB9B974F6E0AC9F00B91BF2820B59B", 1) == 1) {
    var_1 = 0;

    for(;;) {
      var_2 = tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_1, 1);
      var_3 = getoperatorsuperfaction(var_2);
      var_4 = scripts\engine\utility::ter_op(var_3 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

      if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
        break;
      }

      var_5 = int(tablelookupbyrow("_encstr_A11D0EDE83B293161DF64E6EC536E6CE", var_1, 8));

      if(var_5 && isDefined(level.operatorcustomization[var_4][var_2]) && level.operatorcustomization[var_4][var_2].size == 0)
        level.operatorcustomization[var_4][var_2] = undefined;

      var_1++;
    }
  }
}

getoperatorteambyref(var_0) {
  foreach(var_6, var_2 in level.operatorcustomization) {
    foreach(var_5, var_4 in var_2) {
      if(var_5 == var_0)
        return var_6;
    }
  }

  return undefined;
}

getnextoperatorindex(var_0, var_1) {
  if(!var_1) {
    var_2 = 0;

    foreach(var_5, var_4 in level.operatorcustomization[self.team]) {
      if(var_0 == var_5) {
        break;
      }

      var_2++;
    }

    var_6 = undefined;
    var_7 = var_2 + 1;

    if(var_7 == level.operatorcustomization[self.team].size)
      var_7 = 0;

    return var_7;
  } else
    return randomint(level.operatorcustomization[self.team].size);
}

getnextskinindex(var_0, var_1) {
  if(!var_1) {
    var_2 = self getentitynumber();

    if(!isDefined(level.playercustomizationdata))
      level.playercustomizationdata = [];

    var_3 = undefined;

    if(!isDefined(level.playercustomizationdata[var_2]))
      level.playercustomizationdata[var_2] = [];

    if(!isDefined(level.playercustomizationdata[var_2][self.team])) {
      var_4 = spawnStruct();
      var_4.operatorref = var_0;

      if(isai(self))
        var_4.operatorskinindex = self.botskinid;
      else
        var_4.operatorskinindex = restart_watcher(var_0);

      level.playercustomizationdata[var_2][self.team] = var_4;
    }

    var_3 = level.playercustomizationdata[var_2][self.team].operatorskinindex;
    var_5 = tablelookup("_encstr_85751278D29A2DE9B40720300FF1406796BEEE7C", 0, var_3, 1);
    var_6 = 0;

    foreach(var_9, var_8 in level.operatorcustomization[self.team][var_0]) {
      if(var_5 == var_9) {
        break;
      }

      var_6++;
    }

    var_10 = var_6 + 1;

    if(var_10 == level.operatorcustomization[self.team][var_0].size)
      var_10 = 0;

    return var_10;
  } else
    return randomint(level.operatorcustomization[self.team][var_0].size);
}

getplayerlookattarget() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 10000;
  var_4 = ["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"];
  var_5 = physics_createcontents(var_4);
  var_6 = scripts\engine\trace::sphere_trace(var_0, var_3, 5.0, self, var_5, 0);
  var_7 = var_6["_encstr_850E077B0BF30318B9"];

  if(isDefined(var_7) && isPlayer(var_7))
    return var_7;
  else
    return undefined;
}

devmonitoroperatorcustomizationprint() {
  for(;;) {
    waitframe();
    var_0 = [];

    if(getdvarint("_encstr_8E3F1737C69CFADB38CAE4B0E8BD4E7D07C9A5731DF52C1B1B", 0) != 0) {
      initoperatorcustomization();
      var_0 = level.players;
    }

    if(getdvarint("_encstr_85E31A37B14EEB7B1C59C9C2D1DB27FA07C9A59BA3AFE80B4ED9591D", 0) != 0) {
      initoperatorcustomization();
      var_1 = level.players[0] getplayerlookattarget();

      if(!isDefined(var_1)) {
        continue;
      }
      var_0[0] = var_1;
    }

    if(var_0.size > 0) {
      foreach(var_3 in var_0)
      var_3 printcustomization();
    }
  }
}

printcustomization() {
  if(!scripts\mp\utility\teams::isgameplayteam(self.team)) {
    return;
  }
  var_0 = getoperatorcustomization();
}

_id_12304() {
  var_0 = undefined;
  var_1 = 1;

  if(istrue(level.onlinegame)) {
    var_2 = self getfireteammembers();
    var_1 = var_2.size;

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4) && scripts\mp\utility\teams::isgameplayteam(var_4.team)) {
          var_0 = var_4.team;
          self._id_13AC9 = var_4._id_13AC9;
          break;
        }
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = play_reset_priming_anim(var_1);

  if(!isDefined(self._id_13AC9))
    self._id_13AC9 = gettime();

  thread scripts\mp\menus::setteam(var_0);
}

play_reset_priming_anim(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = scripts\mp\utility\teams::getteamcount(var_3);
    var_5 = level.maxteamsize - var_4;

    if(var_5 < var_0) {
      continue;
    }
    if(var_4 > 0) {
      var_6 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B");

      if(isDefined(var_6[0]._id_13AC9) && gettime() > var_6[0]._id_13AC9 + 300000)
        continue;
    }

    var_1 = var_3;
    break;
  }

  return var_1;
}

istempsfxent() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level.teamdata)) {
      var_1 = 400;
      var_2 = 200;
      var_3 = 1;
      var_4 = 0;

      foreach(var_6 in level.teamnamelist) {
        var_3 = 1;
        var_3++;

        foreach(var_8 in level.teamdata[var_6]["_encstr_9775086022BE1B413B8B"]) {
          var_9 = (1, 1, 1);

          if(istrue(var_8.squadassignedfromlobby))
            var_9 = (0, 1, 0);

          var_3++;
        }

        var_2 = var_2 + 100;
        var_4++;

        if(var_4 > 6) {
          var_4 = 0;
          var_1 = var_1 + 200;
          var_2 = 200;
        }
      }
    }

    waitframe();
  }
}

_id_132E6() {
  return getdvarint("_encstr_A65F194B609DA1FB23C81A37F9099F779F38E2C2983B257B39461B", 0) > 0 || getdvarint("_encstr_88A4169A8793F7966B107191497F0AAF90B7790EB477FACB", 0) > 0 || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe();
}