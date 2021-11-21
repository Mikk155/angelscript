const int MAX_MOTD_CHUNK = 45; // 48 and more blend text
const string g_szHelpFile = "scripts/plugins/mikk/config/welcome.txt";
const string g_szLogsFile = "scripts/plugins/mikk/config/logs.txt";
const string g_szRulesFile = "scripts/plugins/mikk/config/rules.txt";

final class CooldownTimes {
	float m_flMotdMessageTime;
	float m_flUHSMessageTime;
//	float m_flMuteMessageTime;
	float m_flMusicMessageTime;
	float m_flVoteMessageTime;
	float m_flVoteMessageTime2;
	float m_flAdminMessageTime;
	float m_flPrivateMessageTime;
	float m_flAmmoNospawnMessageTime;
//	float m_flcertainmapsMessageTime;
	float m_flDifficultVoteMessageTime;
	float m_flDiffStatusMessageTime;
	float m_flAnimoMessageTime;
	
	CooldownTimes(){
		ResetData();
	}
	
	void ResetData(){
		m_flMotdMessageTime = g_Engine.time;
		m_flUHSMessageTime = g_Engine.time;
//		m_flMuteMessageTime = g_Engine.time;
		m_flVoteMessageTime = g_Engine.time;
		m_flVoteMessageTime2 = g_Engine.time;
		m_flAdminMessageTime = g_Engine.time;
		m_flPrivateMessageTime = g_Engine.time;
		m_flAmmoNospawnMessageTime = g_Engine.time;
//		m_flcertainmapsMessageTime = g_Engine.time;
		m_flDifficultVoteMessageTime = g_Engine.time;
		m_flDiffStatusMessageTime = g_Engine.time;
		m_flAnimoMessageTime = g_Engine.time;
	}
}

CooldownTimes@ g_CooldownTimes;

void PluginInit(){
	g_Module.ScriptInfo.SetAuthor( "Limitless Potential" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/Dj9tcTfuM8" );
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @discord );
	
	CooldownTimes ctimes();
	@g_CooldownTimes = @ctimes;
	
	Initialize();
	
}

void MapInit()
{
  string mapname = g_Engine.mapname;
  
	bool adLobby = false;
	if(mapname.Find("campaign") == 0) adLobby = true;
	bool adLoby = false;
	if(mapname.Find("dynamic") == 0) adLoby = true;
	bool adOf = false;
	if(mapname.Find("of_c") == 0) adOf = true;
	bool adHl = false;
	if(mapname.Find("hl_c") == 0) adHl = true;
	bool adAst = false;
	if(mapname.Find("ast") == 0) adAst = true;
	bool adHcl = false;
	if(mapname.Find("hc_hl_") == 0) adHcl = true;
	bool adBarn = false;
	if(mapname.Find("blue") == 0) adBarn = true;
	bool adAcces = false;
	if(mapname.Find("mk_access") == 0) adAcces = true;
	bool adTunnel = false;
	if(mapname.Find("tunnel") == 0) adTunnel = true;
	bool adBtg = false;
	if(mapname.Find("mk_bridge") == 0) adBtg = true;
	bool adStacj = false;
	if(mapname.Find("mk_stacj") == 0) adStacj = true;
	bool adRp = false;
	if(mapname.Find("rp_") == 0) adRp = true;
	bool adHween = false;
	if(mapname.Find("schall") == 0) adHween = true;
	bool adXmass = false;
	if(mapname.Find("xmass_") == 0) adXmass = true;
	bool adAff = false;
	if(mapname.Find("afflict") == 0) adAff = true;
	bool adAom = false;
	if(mapname.Find("aom_") == 0) adAom = true;
	bool adAomnm = false;
	if(mapname.Find("mk_aom_") == 0) adAomnm = true;
	bool adAi = false;
	if(mapname.Find("arctic_incident*") == 0) adAi = true;
	bool adRev = false;
	if(mapname.Find("revivi") == 0) adRev = true;
	bool adRes = false;
	if(mapname.Find("restriction") == 0) adRes = true;
  
  if(adLobby)
    g_EngineFuncs.ServerCommand("hostname \"Mikk's Server: Hardcore [Limitless Potential]\"\n");
  if(adLoby)
    g_EngineFuncs.ServerCommand("hostname \"Mikk's Server: Hardcore [Limitless Potential]\"\n");
  if(adOf)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Opposing-Force Hardcore\"\n");
  if(adHl)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Half-Life Hardcore\"\n");
  if(adAst)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] A Soldiers Tale Hardcore\"\n");
  if(adHcl)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Hardcore-Life Hardcore\"\n");
  if(adBarn)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Blue Shift Hardcore\"\n");
  if(adAcces)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Access Point Hardcore\"\n");
  if(adTunnel)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Tunnel vision Hardcore\"\n");
  if(adBtg)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Bridge The Gap Hardcore\"\n");
  if(adStacj)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Stacja Hardcore\"\n");
  if(adRp)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Residual Point Hardcore\"\n");
  if(adHween)
    g_EngineFuncs.ServerCommand("hostname \"Hardcore Halloween Edition [Limitless Potential]\"\n");
  if(adXmass)
    g_EngineFuncs.ServerCommand("hostname \"Hardcore Christmass Edition [Limitless Potential]\"\n");
  if(adAff)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Affliction Hardcore\"\n");
  if(adAom)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Afraid Of Monsters: Custom\"\n");
  if(adAomnm)
    g_EngineFuncs.ServerCommand("hostname \"[LP] Afraid Of Monsters: NIGTHMARE MODE\"\n");
  if(adAi)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Arctic Insident Hardcore\"\n");
  if(adRev)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Reviviscense Hardcore\"\n");
  if(adRes)
    g_EngineFuncs.ServerCommand("hostname \"[Limitless Potential] Restriction Hardcore\"\n");
	
  g_EngineFuncs.ServerExecute();
  g_CooldownTimes.ResetData();
}

void Initialize() {
	g_Hooks.RegisterHook( Hooks::Player::ClientSay, @ClientSay );
}

bool IsCharacterBigLetter(string str, uint i){
	return str[i] == 'A' || str[i] == 'B' || str[i] == 'C' || str[i] == 'D' || 
	str[i] == 'E' || str[i] == 'F' || str[i] == 'G' || str[i] == 'H' || 
	str[i] == 'I' || str[i] == 'J' || str[i] == 'K' || str[i] == 'L' || 
	str[i] == 'M' || str[i] == 'N' || str[i] == 'O' || str[i] == 'P' || 
	str[i] == 'Q' || str[i] == 'R' || str[i] == 'S' || str[i] == 'T' || 
	str[i] == 'U' || str[i] == 'V' || str[i] == 'W' || str[i] == 'X' || 
	str[i] == 'Y' || str[i] == 'Z';
}

void ChatCheck( SayParameters@ m_pArgs ) {
	string str = m_pArgs.GetCommand();
	str.ToUppercase();
	bool strTest = false;
	bool readyPrint = true;
	
	if (str.Find("ADMIN_") == 0) return;
	
	strTest = (str.Find("AMMO") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("STOLE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("TAKE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LIMITED") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("BULLET") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("WASTE") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flAmmoNospawnMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flAmmoNospawnMessageTime = g_Engine.time + 120.0f;
		string aStr = "Limitless Potential: The ammo will not respawn. Don't take all by yourself.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"The ammo will not respawn. Don't take all by yourself.\"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

	strTest = (str.Find("PRIVATE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLEASE LEAVE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLEASE LEFT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLS LEAVE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLS LEFT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLX LEAVE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLX LEFT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLZ LEAVE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("PLZ LEFT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEAVE PLEASE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEFT PLEASE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEAVE PLS") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEFT PLS") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEAVE PLX") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEFT PLX") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEAVE PLZ") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LEFT PLZ") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("GET OUT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("DIE PLZ") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("DIE PLEASE") < String::INVALID_INDEX);
	strTest = strTest || ((str.Find("QUIT") < String::INVALID_INDEX) && !(str.Find("QUITE") < String::INVALID_INDEX));
	strTest = strTest || (str.Find("DISCONNECT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ALONE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("SOLO") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("VOTEKICK") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("KICK") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("VOTE KICK") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NWORD") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("WAFN") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NEGGUS") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NEGUS") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NIGA") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("FUCKYOU") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("SUICIDE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NIGGA") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flPrivateMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flPrivateMessageTime = g_Engine.time + 20.0f;
		string aStr = "Limitless Potential: Don't be an asshole. follow our rules or your ass will be hard beated.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"Don't be an asshole. follow our rules or your ass will be hard beated.\"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

/*	strTest = (str.Find("MUTE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MUTING") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ERRAPED") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MUTE SOUND") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("TURN OFF") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("HOW MUTE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MY EARS") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("VOLUME") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("CHATSOUND") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("CANT HEAR") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ANNOYING") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flMuteMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flMuteMessageTime = g_Engine.time + 30.0f;
		string aStr = "Limitless Potential: say .csmute to toggle un/mute all chatsounds.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say .csmute to toggle un/mute all chatsounds.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}*/
	
	strTest = (str.Find("MUSIC") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MP3") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("LISTEN") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("SONG") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flMusicMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flMusicMessageTime = g_Engine.time + 30.0f;
		string aStr = "Limitless Potential: say /mma to listen some songs then /mma config\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say /mma to listen some songs then /mma config\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

	strTest = (str.Find("VOTE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("RTV") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("CHANGE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MAP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("HOW CHANGE") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flVoteMessageTime2 < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flVoteMessageTime2 = g_Engine.time + 120.0f;
		string aStr = "Limitless Potential: say /votemap to open the mapvote menu.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say /votemap to open the mapvote menu.\"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

	strTest = (str.Find("KICK") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("BAN") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("BUG") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ADMIN") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flAdminMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flAdminMessageTime = g_Engine.time + 120.0f;
		string aStr = "Limitless Potential: Join our discord for Admin-Contact. discord.gg/Dj9tcTfuM8 \n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"Join our discord for Admin-Contact. discord.gg/Dj9tcTfuM8 \"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

/*	strTest = (str.Find("MAP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flcertainmapsMessageTime < g_Engine.time);

	string mapname = string(g_Engine.mapname);
	bool mapTest = mapname.opEquals("mk_stacja");
	mapTest = mapTest || mapname.opEquals("mk_accesspoint");
	mapTest = mapTest || mapname.opEquals("mk_bridge_the_gap");
	mapTest = mapTest || mapname.opEquals("bridgethegap");

	if (strTest && mapTest && readyPrint) {
		g_CooldownTimes.m_flcertainmapsMessageTime = g_Engine.time + 300.0f;
		string aStr = "Limitless Potential:		\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"		\"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}*/

	strTest = (str.Find("DROPAMMO") < String::INVALID_INDEX);
	strTest = strTest || ((str.Find("GLOW") < String::INVALID_INDEX) && !(str.Find("TRAIL MENU") < 2) && !(str.Find("GLOW MENU") < 2));
	strTest = strTest || (str.Find("TRAIL") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("BUY") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("SHOP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("MONEY") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flUHSMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flUHSMessageTime = g_Engine.time + 30.0f;
		string aStr = "?\n";
		g_Game.AlertMessage( at_logged, "\"\" says \"?\"\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

	strTest = (str.Find("HELP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("INFORMATION") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("SERVER") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flMotdMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flMotdMessageTime = g_Engine.time + 300.0f;
		string aStr = "Limitless Potential: say !help, rules or info to open Server-Rules and useful information.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say !help, rules or info to open Server-Rules and useful information.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}

	strTest = (str.Find("EASY") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("CLEAR") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("EZ") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ENEMY") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("HARD") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flDifficultVoteMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flDifficultVoteMessageTime = g_Engine.time + 60.0f;
		string aStr = "Limitless Potential: say /d100 to enable maximun difficult.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say /d100 to enable maximun difficult.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}
	
	strTest = (str.Find("HARD") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("HARDCORE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("1HIT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("1 HIT") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("1HP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ONE HP") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("ONE HIT") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flDiffStatusMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flDiffStatusMessageTime = g_Engine.time + 60.0f;
		string aStr = "Limitless Potential: say /d(number) to start a difficulty vote. (x10 divisible)\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \"say /d(number) to start a difficulty vote. (x10 divisible)\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}
	
	strTest = (str.Find("IMPOSIBLE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("IMPOSSIBLE") < String::INVALID_INDEX);
	strTest = strTest || (str.Find("NOT POSSIBLE") < String::INVALID_INDEX);
	strTest = strTest && (g_CooldownTimes.m_flAnimoMessageTime < g_Engine.time);

	if (strTest && readyPrint) {
		g_CooldownTimes.m_flAnimoMessageTime = g_Engine.time + 60.0f;
		string aStr = "Limitless Potential: Nothing is impossible.\n";
		g_Game.AlertMessage( at_logged, "\"Limitless Potential\" says \" Nothing is impossible.\n" );
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, aStr ); 
		readyPrint = false;
	}
}

HookReturnCode discord( SayParameters@ pParams){
	CBasePlayer@  pPlayer = pParams.GetPlayer();
	const CCommand@ pArguments = pParams.GetArguments();
  	
	if( pArguments.ArgC() >= 1 )
	{
		if( pArguments[ 0 ] == "/discord" || pArguments.Arg(0).ToLowercase() == "/DISCORD" || pArguments.Arg(0).ToLowercase() == "DISCORD" || pArguments.Arg(0).ToLowercase() == "discord" ){
            
            
            g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "[LP] Join our discord Server. \n");
  			g_PlayerFuncs.ClientPrint(  pPlayer, HUD_PRINTTALK, "https://discord.gg/Dj9tcTfuM8 \n");
		}
	}



	return HOOK_CONTINUE;
}

HookReturnCode ClientSay( SayParameters@ pParams ) {
	ChatCheck( pParams );

	const CCommand@ pArguments = pParams.GetArguments();

	if ( pArguments.ArgC() >= 1 )
	{
		string szArg = pArguments.Arg( 0 );
		if ( szArg.ICompare( "motd" ) == 0 || szArg.ICompare( "!help" ) == 0 || szArg.ICompare( "menu" ) == 0 || szArg.ICompare( "info" ) == 0  || szArg.ICompare( "information" ) == 0 )
		{
			CBasePlayer@ pPlayer = pParams.GetPlayer();

			if ( pPlayer is null || !pPlayer.IsConnected() )
				return HOOK_HANDLED;

			ShowMotd( pPlayer, g_szHelpFile, "HELP" );

			return HOOK_HANDLED;
		}
	}
	
	if ( pArguments.ArgC() >= 1 )
	{
		string szArg = pArguments.Arg( 0 );
		if ( szArg.ICompare( "/logs" ) == 0 || szArg.ICompare( "/changelog" ) == 0 || szArg.ICompare( "/log" ) == 0 || szArg.ICompare( "/whatsnew" ) == 0  || szArg.ICompare( "logs" ) == 0 )
		{
			CBasePlayer@ pPlayer = pParams.GetPlayer();

			if ( pPlayer is null || !pPlayer.IsConnected() )
				return HOOK_HANDLED;

			ShowMotd( pPlayer, g_szLogsFile, "changelog" );

			return HOOK_HANDLED;
		}
	}
	
	if ( pArguments.ArgC() >= 1 )
	{
		string szArg = pArguments.Arg( 0 );
		if ( szArg.ICompare( "/rules" ) == 0 || szArg.ICompare( "rules" ) == 0 || szArg.ICompare( "admins" ) == 0 )
		{
			CBasePlayer@ pPlayer = pParams.GetPlayer();

			if ( pPlayer is null || !pPlayer.IsConnected() )
				return HOOK_HANDLED;

			ShowMotd( pPlayer, g_szRulesFile, "rules" );

			return HOOK_HANDLED;
		}
	}
	return HOOK_CONTINUE;
}

void CmdMotd( const CCommand@ args )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;
		
	ShowMotd( pPlayer, g_szHelpFile, "HELP" );
}

CClientCommand motd( "motd", "Show Motd", @CmdMotd );

void CmdHelp( const CCommand@ args )
{
	CBasePlayer@ pPlayer = g_ConCommandSystem.GetCurrentPlayer();
	
	if ( pPlayer is null || !pPlayer.IsConnected() )
		return;

	File@ pFile = g_FileSystem.OpenFile( g_szHelpFile, OpenFile::READ );

	if ( pFile !is null && pFile.IsOpen() )
	{
		string line, szToShow;
		while ( !pFile.EOFReached() )
		{
			pFile.ReadLine( line );
			line.Trim();
			line.Trim( '\r' );
				
			szToShow += line + "\n";
		}

		pFile.Close();
		g_EngineFuncs.ClientPrintf( pPlayer, print_console, szToShow );
	}
}

CClientCommand help( "help", "Help", @CmdHelp );

bool ShowMotd( CBasePlayer@ pPlayer, string& in szBody, string& in szHead = "" )
{
	int ilen = szHead.Length();
	
	if ( ilen <= 0 )
		szHead = g_EngineFuncs.CVarGetString( "hostname" ); //g_pvHostname.GetString();

	ilen = szBody.Length();
	int iFile = 0;
	string szToShow; // = szBody;
	
	if ( ilen < 128 )
	{
		File@ pFile = g_FileSystem.OpenFile( szBody, OpenFile::READ );
		
		if ( pFile !is null && pFile.IsOpen() )
		{
			string line;
			while ( !pFile.EOFReached() )
			{
				pFile.ReadLine( line );
				line.Trim();
				
				szToShow += line + "\n";
			}

			pFile.Close();
			iFile = szToShow.Length();
		}
	}
	
	if ( iFile <= 0 )
		szToShow = szBody;
	else
		ilen = iFile;
	
	if ( pPlayer is null )
	{
		g_Game.AlertMessage( at_error, "Invalid player id %1\n", pPlayer.entindex() );
		return false;
	}
	
	if ( pPlayer.IsConnected() )
		UTIL_ShowMOTD( pPlayer.edict(), szToShow, ilen, szHead );
	
	return true;
}

void UTIL_ShowMOTD( edict_t@ client, string motd, int mlen, const string name )
{
	const string hostname = g_EngineFuncs.CVarGetString( "hostname" ); //g_pvHostname.GetString();

	if ( !hostname.IsEmpty() && hostname != name )
	{
		NetworkMessage msgname( MSG_ONE, NetworkMessages::ServerName, g_vecZero, client );
		msgname.WriteString( name );
		msgname.End();
	}

	string chunk;
	int a = 0;

	while ( mlen > a )
	{
		chunk = motd.SubString( a, a + MAX_MOTD_CHUNK > mlen ? mlen - a : MAX_MOTD_CHUNK );
		a += MAX_MOTD_CHUNK;

		NetworkMessage msgmotd( MSG_ONE, NetworkMessages::MOTD, g_vecZero, client );
		msgmotd.WriteByte( chunk.Length() == MAX_MOTD_CHUNK ? uint8( 0 ) : uint8( 1 ) ); // 0 means there is still more message to come
		msgmotd.WriteString( chunk );
		msgmotd.End();	
	}
	
	if ( !hostname.IsEmpty() && hostname != name )
	{
		NetworkMessage msghostname( MSG_ONE, NetworkMessages::ServerName, g_vecZero, client );
		msghostname.WriteString( hostname );
		msghostname.End();
	}
}