local versionNumber = GetAddOnMetadata("AuctionHouseNotifications", "Version")

if locale == "enUS" then
    addonTitle = "Auction House Notifications"
    greetingMessage = "|cFFFFFF00Auction House Notifications|r loaded successfully! ("..versionNumber..")"
    subtitle = "Created by Breno Ludgero\nVersion "..versionNumber
    soundPreferences = "Sound Preferences"
    enableInAHText = "Enable in Auction House"
    enableInAHTooltip = "Enable or disable alerts for successful auctions\nwhen the auction house window is open"
    enableExpired = "Enable Expired Auction Alerts"
    successfulSoundText = "Successful Sound"
    failedSoundText = "Failure Sound"
    expiredSoundText = "Expired Sound"
    successfulText = "Successful"
    failedText = "Failure"
    expiredText = "Expired"
    soundCategoryNames = {
        "Coins",
        "Female Human",
        "Fireworks",
        "Impact",
        "Quests",
        "Sheep",
        "Thunder",
        "What?",
        "Growl",
        "Chicken"
    }
    testSounds = "Test Sounds"
    soundChannelText = "Sound Channel"
    soundChannelNames = {
        "Master",
        "Sound",
        "Music",
        "Ambience",
        "Dialog"
    }
    soundChannelTooltip = "The sound channel to be used by alerts"
    miscellaneous = "Miscellaneous"
    showGreetingMessage = "Show Greeting Message"

elseif locale == "esMX" or locale == "esES" then
    addonTitle = "Notificaciones de Casa de Subastas"
    greetingMessage = "|cFFFFFF00Notificaciones de Casa de Subastas|r ¡se ha cargado correctamente! ("..versionNumber..")"
    subtitle = "Creado por Breno Ludgero\nVersión "..versionNumber
    soundPreferences = "Preferencias de Sonido"
    enableInAHText = "Habilitar en la Casa de Subastas"
    enableInAHTooltip = "Habilita o deshabilita las alertas para subastas exitosas\ncuando la ventana de la casa de subastas está abierta"
    enableExpired = "Activar Alertas de Subastas Expiradas"
    successfulSoundText = "Sonido de Éxito"
    failedSoundText = "Sonido de Fracaso"
    expiredSoundText = "Sonido de Expiración"
    successfulText = "Éxito"
    failedText = "Fracaso"
    expiredText = "Expiración"
    soundCategoryNames = {
        "Monedas",
        "Humana",
        "Fuegos Artificiales",
        "Impacto",
        "Misiones",
        "Ovejas",
        "Trueno",
        "¿Qué?",
        "Gruñido",
        "Pollo"
    }
    testSounds = "Prueba de Sonidos"
    soundChannelText = "Canal de Sonido"
    soundChannelNames = {
        "Principal",
        "Sonido",
        "Música",
        "Ambiente",
        "Diálogo"
    }
    soundChannelTooltip = "El canal de sonido que se utilizará para las alertas"
    miscellaneous = "Misceláneo"
    showGreetingMessage = "Mostrar Mensaje de Bienvenida"

elseif locale == "ptBR" then
    addonTitle = "Notificações da Casa de Leilões"
    greetingMessage = "|cFFFFFF00Notificações da Casa de Leilões|r carregado com sucesso! ("..versionNumber..")"
    subtitle = "Criado por Breno Ludgero\nVersão "..versionNumber
    soundPreferences = "Preferências de Som"
    enableInAHText = "Ativar na Casa de Leilões"
    enableInAHTooltip = "Ativa ou desativa alertas para leilões bem-sucedidos\nquando a janela da casa de leilões está aberta"
    enableExpired = "Ativar Alertas de Leilões Vencidos"
    successfulSoundText = "Som de Sucesso"
    failedSoundText = "Som de Falha"
    expiredSoundText = "Som de Vencimento"
    successfulText = "Sucesso"
    failedText = "Falha"
    expiredText = "Vencimento"
    soundCategoryNames = {
        "Moedas",
        "Humana",
        "Fogos de Artifício",
        "Impacto",
        "Missões",
        "Ovelhas",
        "Trovão",
        "O quê?",
        "Rosnado",
        "Galinha"
    }
    testSounds = "Teste de Sons"
    soundChannelText = "Canal de Som"
    soundChannelNames = {
        "Principal",
        "Som",
        "Música",
        "Ambiente",
        "Diálogo"
    }
    soundChannelTooltip = "O canal de som a ser usado pelas notificações"
    miscellaneous = "Diversos"
    showGreetingMessage = "Mostrar Mensagem de Saudação"

elseif locale == "deDE" then
    addonTitle = "Auktionshaus-Benachrichtigungen"
    greetingMessage = "|cFFFFFF00Auktionshaus-Benachrichtigungen|r erfolgreich geladen! ("..versionNumber..")"
    subtitle = "Erstellt von Breno Ludgero\nVersion "..versionNumber
    soundPreferences = "Soundeinstellungen"
    enableInAHText = "Aktivieren im Auktionshaus"
    enableInAHTooltip = "Aktiviert oder deaktiviert Benachrichtigungen für erfolgreiche Auktionen\nwenn das Auktionshaus-Fenster geöffnet ist"
    enableExpired = "Benachrichtigungen Über Abgelaufen Auktionen Aktivieren"
    successfulSoundText = "Erfolgreiche Geräusch"
    failedSoundText = "Fehlgeschlagen Geräusch"
    expiredSoundText = "Abgelaufen Geräusch"
    successfulText = "Erfolgreich"
    failedText = "Fehlgeschlagen"
    expiredText = "Abgelaufen"
    soundCategoryNames = {
        "Münzen",
        "Weiblicher Mensch",
        "Feuerwerk",
        "Einschlag",
        "Quests",
        "Schafe",
        "Donner",
        "Was?",
        "Knurren",
        "Huhn"
    }
    testSounds = "Geräuschtest"
    soundChannelText = "Soundkanal"
    soundChannelNames = {
        "Haupt",
        "Ton",
        "Musik",
        "Umgebung",
        "Dialog"
    }
    soundChannelTooltip = "Der Soundkanal, der von Benachrichtigungen verwendet wird"
    miscellaneous = "Sonstiges"
    showGreetingMessage = "Begrüßungsnachricht Anzeigen"

elseif locale == "frFR" then
    addonTitle = "Notifications de l'Hôtel des Ventes"
    greetingMessage = "|cFFFFFF00Notifications de l'Hôtel des Ventes|r chargé avec succès! ("..versionNumber..")"
    subtitle = "Créé par Breno Ludgero\nVersion "..versionNumber
    soundPreferences = "Préférences Sonores"
    enableInAHText = "Activer dans l'Hôtel des Ventes"
    enableInAHTooltip = "Activer ou désactiver les alertes pour les ventes aux enchères réussies\nlorsque la fenêtre de l'hôtel des ventes est ouverte"
    enableExpired = "Activer les Alertes d'Enchères Expirées"
    successfulSoundText = "Son d'succès"
    failedSoundText = "Son d'échec"
    expiredSoundText = "Son d'expiration"
    successfulText = "Succès"
    failedText = "Échec"
    expiredText = "Expiration"
    soundCategoryNames = {
        "Pièces",
        "Humain Femme",
        "Feux d'artifice",
        "Impact",
        "Quêtes",
        "Moutons",
        "Tonnerre",
        "Quoi?",
        "Grogner",
        "Poulet"
    }
    testSounds = "Test de Sons"
    soundChannelText = "Canal Sonore"
    soundChannelNames = {
        "Principal",
        "Son",
        "Musique",
        "Ambiance",
        "Dialogue"
    }
    soundChannelTooltip = "Le canal sonore à utiliser pour les alertes"
    miscellaneous = "Divers"
    showGreetingMessage = "Afficher le Message de Bienvenue"

elseif locale == "itIT" then
    addonTitle = "Notifiche della Casa d'Aste"
    greetingMessage = "|cFFFFFF00Notifiche della Casa d'Aste|r sono state aperte con successo! ("..versionNumber..")"
    subtitle = "Creato da Breno Ludgero\nVersion "..versionNumber
    soundPreferences = "Preferenze di Suono"
    enableInAHText = "Attivare nella Casa d'Aste"
    enableInAHTooltip = "Abilitare o disabilitare gli avvisi per le aste andate a buon fine\nquando la finestra della casa d'aste è aperta"
    enableExpired = "Abilitare gli Avvisi di Asta Scaduti"
    successfulSoundText = "Suono di Successo"
    failedSoundText = "Suono di Fallimento"
    expiredSoundText = "Suono di Scadenza"
    successfulText = "Successo"
    failedText = "Fallimento"
    expiredText = "Scadenza"
    soundCategoryNames = {
        "Monete",
        "Umana",
        "Fuochi d'artificio",
        "Impatto",
        "Missioni",
        "Pecora",
        "Tuono",
        "Cosa?",
        "Ringhio",
        "Pollo"
    }
    testSounds = "Suoni di Prova"
    soundChannelText = "Canale Sonoro"
    soundChannelNames = {
        "Principale",
        "Suono",
        "Musica",
        "Ambiente",
        "Dialogo"
    }
    soundChannelTooltip = "Il canale sonoro da utilizzare per gli avvisi"
    miscellaneous = "Varie"
    showGreetingMessage = "Mostra Messaggio di Saluto"

elseif locale == "ruRU" then
    addonTitle = "Уведомления Aукционного Дома"
    greetingMessage = "|cFFFFFF00Уведомления Aукционного Дома|r онлайн! ("..versionNumber..")"
    subtitle = "Создано Breno Ludgero\nВерсия "..versionNumber
    soundPreferences = "Настройки Звука"
    enableInAHText = "Доступно в Aукционном Дом"
    enableInAHTooltip = "Включение и отключение оповещений об успешных аукционах\nпри открытом окне аукционного дом"
    enableExpired = "Включить Оповещения об Аукциона с Истекшим Cроком Действия"
    successfulSoundText = "Успешный Звук"
    failedSoundText = "Звук Oтказа"
    expiredSoundText = "Истекший Срок Звука"
    successfulText = "Успешный"
    failedText = "Oтказа"
    expiredText = "Истекший"
    soundCategoryNames = {
        "Монеты",
        "Женщина",
        "Фейерверк",
        "Удар",
        "Заданий",
        "Овцы",
        "Гром",
        "Что?",
        "Рычание",
        "Курица"
    }
    testSounds = "Тестовые Звуки"
    soundChannelText = "Звуковой Канал"
    soundChannelNames = {
        "Основной",
        "Звук",
        "Музыка",
        "Атмосфера",
        "Диалог"
    }
    soundChannelTooltip = "Звуковой канал который будет использоваться оповещениями"
    miscellaneous = "Разное"
    showGreetingMessage = "Показать Приветственное Сообщение"

elseif locale == "koKR" then
    addonTitle = "경매장 알림"
    greetingMessage = "|cFFFFFF00경매장 알림|r 성공적으로 로드되었습니다! ("..versionNumber..")"
    subtitle = "Breno Ludgero에 의해 작성됨\n버전 "..versionNumber
    soundPreferences = "소리 설정"
    enableInAHText = "경매장에서 사용 가능"
    enableInAHTooltip = "경매장 창이 열려 있을 때 성공적인 경매에 대한 알림을\n사용하거나 사용하지 않도록 설정합니다."
    enableExpired = "만료된 경매 알림 사용"
    successfulSoundText = "성공 사운드"
    failedSoundText = "실패 사운드"
    expiredSoundText = "만료 사운드"
    successfulText = "성공"
    failedText = "실패"
    expiredText = "만료"
    soundCategoryNames = {
        "동전",
        "여성 인간",
        "불꽃놀이",
        "충격",
        "퀘스트",
        "양",
        "천둥",
        "뭐라고?",
        "으르렁거림",
        "치킨"
    }
    testSounds = "테스트 사운드"
    soundChannelText = "음향 채널"
    soundChannelNames = {
        "마스터",
        "효과음",
        "음악",
        "환경음",
        "대화음"
    }
    soundChannelTooltip = "알림에 사용할 음향 채널"
    miscellaneous = "기타"
    showGreetingMessage = "인사 메시지 표시"    

elseif locale == "zhTW" then
    addonTitle = "拍賣行公告"
    greetingMessage = "|cFFFFFF00拍賣行公告|r 載入成功！("..versionNumber..")"
    subtitle = "由Breno Ludgero創建\n版本 "..versionNumber
    soundPreferences = "音效偏好設定"
    enableInAHText = "在拍賣行啟用"
    enableInAHTooltip = "在拍賣行視窗開啟時\n啟用或停用成功拍賣的警示"
    enableExpired = "啟用過期的競價提醒"
    successfulSoundText = "成功音效"
    failedSoundText = "失敗音效"
    expiredSoundText = "过過期音"
    successfulText = "成功"
    failedText = "失敗"
    expiredText = "過期"
    soundCategoryNames = {
        "硬幣",
        "女性人類",
        "煙火",
        "衝擊",
        "任務",
        "綿羊",
        "雷霆",
        "什麼？",
        "吼叫声",
        "雞"
    }
    testSounds = "測試音效"
    soundChannelText = "音效頻道"
    soundChannelNames = {
        "主音量",
        "音效",
        "音樂",
        "環境聲音",
        "對話"
    }
    soundChannelTooltip = "警示所使用的音效頻道"
    miscellaneous = "其他"
    showGreetingMessage = "顯示問候訊息"

elseif locale == "zhCN" then
    addonTitle = "拍卖行公告"
    greetingMessage = "|cFFFFFF00拍卖行公告|r加载成功！("..versionNumber..")"
    subtitle = "由Breno Ludgero创建\n版本 "..versionNumber
    soundPreferences = "声音偏好设置"
    enableInAHText = "在拍卖行启用"
    enableInAHTooltip = "在拍卖行窗口打开时\n启用或禁用成功拍卖的警报"
    enableExpired = "启用过期的竞价提醒"
    successfulSoundText = "成功音效"
    failedSoundText = "失败音效"
    expiredSoundText = "过过期音"
    successfulText = "成功"
    failedText = "失败"
    expiredText = "过期"
    soundCategoryNames = {
        "硬币",
        "女性人类",
        "烟花",
        "冲击",
        "任务",
        "绵羊",
        "雷霆",
        "什么？",
        "吼叫声",
        "鸡"
    }
    testSounds = "测试音效"
    soundChannelText = "声音通道"
    soundChannelNames = {
        "主音量",
        "音效",
        "音乐",
        "环境声音",
        "对话"
    }
    soundChannelTooltip = "用于警报的声音通道"
    miscellaneous = "杂项"
    showGreetingMessage = "显示问候消息"
end
