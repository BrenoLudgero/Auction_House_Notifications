-- Saves the addOn version number from the .toc file
local versionNumber = GetAddOnMetadata("AuctionHouseNotifications", "Version")

-- Patterns to be scanned in CHAT_MSG_SYSTEM events
successfulAuctionMessages = {
    "Your auction of (.+) sold%.", "You won an auction for (.+)", "A buyer has been found for your auction of (.+)",  -- enUS
    "Has vendido (.+) en la subasta%.", "Has ganado una puja por (.+)", "Tu (.+) se ha vendido%.", "Ha aparecido un comprador para tu subasta de (.+)",  -- esMX, esES
    "Vente de votre (.+) réussie", "Vous avez gagné les enchères pour (.+)", "Un acheteur a été trouvé pour votre enchère (.+)",  -- frFR
    -- itIT
    "Você vendeu (.+) no leilão%.", "Você ganhou um leilão de (.+)", "Há um comprador para o seu leilão de (.+)",  -- ptBR
    "Versteigerung: (.+) wurde verkauft%.", "Ihr habt eine Auktion gewonnen für: (.+)", "Es wurde ein Käufer für Eure Auktion gefunden: (.+)", -- deDE
    "На ваш товар (.+) нашелся покупатель%.", "(.+) предмет куплен. Вы выиграли торги%.", "На ваш товар (.+) нашелся покупатель%.",  -- ruRU
    "경매에 올린 (.+) 판매되었습니다%.", "(.+) 경매에 낙찰되었습니다%.", "경매에 올린 (.+)의 구매자가 나타났습니다%.",  -- koKR
    "你拍賣的(.+)已經售出。", "你贏得了(.+)的競標",  "一位買家已經購得你拍賣的(.+)",  -- zhTW
    "你拍卖的(.+)已经售出。", "你赢得了对(.+)的竞标", "你拍卖的(.+)已经售出。"  -- zhCN
}
failedAuctionMessages = {
    "You have been outbid on (.+)%.", 
    "Alguien ha superado tu puja por (.+)%.", "Alguien ha pujado por tu (.+)%.", 
    "Vous n'êtes plus le plus offrant pour (.+)%.", 
    -- itIT
    "Superaram seu lance em (.+)%.", 
    "Ihr wurdet bei (.+) überboten%.", 
    "(.+) предмет перекуплен%.", 
    "(.+) 다른 플레이어에 의해 상회 입찰되었습니다%.", 
    "你對(.+)的出價被人超過了。", 
    "你对(.+)的出价被人超过了。"
}
expiredAuctionMessages = {
    "Your auction of (.+) has expired%.",
    "Tu subasta de (.+) ha caducado%.",
    "Votre vente aux enchères (.+) est terminée", "Votre vente aux enchères (.+) est terminée%.",
    -- itIT
    "O leilão de (.+) expirou%.",
    "Eure Auktion von (.+) ist abgelaufen%.",
    "Ваш товар (.+) снят с аукциона%.",
    "(.+) 경매가 만료되었습니다%.",
    "你拍賣的(.+)已經過期。",
    "你拍卖的(.+)已经过期。"
}

-- Localized title to be used in the in-game addOn list
addonTitles = {
    enUS = "Auction House Notifications",
    esMX = "Notificaciones de Casa de Subastas",
    esES = "Notificaciones de Casa de Subastas",
    ptBR = "Notificações da Casa de Leilões",
    deDE = "Auktionshaus-Benachrichtigungen",
    frFR = "Notifications de l'Hôtel des Ventes",
    itIT = "Notifiche della Casa d'Aste",
    ruRU = "Уведомления Aукционного Дом",
    koKR = "경매장 알림",
    zhTW = "拍賣行公告",
    zhCN = "拍卖行公告"
}
-- Localized message to be shown in the chat when the addOn loads
greetingMessages = {
    enUS = "|cFFFFFF00Auction House Notifications|r loaded successfully! (" ..versionNumber.. ")",
    esMX = "|cFFFFFF00Notificaciones de Casa de Subastas|r ¡se ha cargado correctamente! (" ..versionNumber.. ")",
    esES = "|cFFFFFF00Notificaciones de Casa de Subastas|r ¡se ha cargado correctamente! (" ..versionNumber.. ")",
    ptBR = "|cFFFFFF00Notificações da Casa de Leilões|r carregado com sucesso! (" ..versionNumber.. ")",
    deDE = "|cFFFFFF00Auktionshaus-Benachrichtigungen|r erfolgreich geladen! (" ..versionNumber.. ")",
    frFR = "|cFFFFFF00Notifications de l'Hôtel des Ventes|r chargé avec succès! (" ..versionNumber.. ")",
    itIT = "|cFFFFFF00Notifiche della Casa d'Aste|r sono state aperte con successo! (" ..versionNumber.. ")",
    ruRU = "|cFFFFFF00Уведомления Aукционного Дом|r онлайн! (" ..versionNumber.. ")",
    koKR = "|cFFFFFF00경매장 알림|r 성공적으로 로드되었습니다! (" ..versionNumber.. ")",
    zhTW = "|cFFFFFF00拍賣行公告|r 載入成功！(" ..versionNumber.. ")",
    zhCN = "|cFFFFFF00拍卖行公告|r 加载成功！(" ..versionNumber.. ")"
}

-- Localized options interface text
subtitleText = {
    enUS = "Created by Breno Ludgero\nVersion " ..versionNumber,
    esMX = "Creado por Breno Ludgero\nVersión " ..versionNumber,
    esES = "Creado por Breno Ludgero\nVersión " ..versionNumber,
    ptBR = "Criado por Breno Ludgero\nVersão " ..versionNumber,
    deDE = "Erstellt von Breno Ludgero\nVersion " ..versionNumber,
    frFR = "Créé par Breno Ludgero\nVersion " ..versionNumber,
    itIT = "Creato da Breno Ludgero\nVersion " ..versionNumber,
    ruRU = "Создано Breno Ludgero\nВерсия " ..versionNumber,
    koKR = "Breno Ludgero에 의해 작성됨\n버전 " ..versionNumber,
    zhTW = "由Breno Ludgero創建\n版本 " ..versionNumber,
    zhCN = "由Breno Ludgero创建\n版本 " ..versionNumber
}
soundPreferencesTexts = {
    enUS = "Sound Preferences",
    esMX = "Preferencias de Sonido",
    esES = "Preferencias de Sonido",
    ptBR = "Preferências de Som",
    deDE = "Soundeinstellungen",
    frFR = "Préférences Sonores",
    itIT = "Preferenze di Suono",
    ruRU = "Настройки Звука",
    koKR = "소리 설정",
    zhTW = "音效偏好設定",
    zhCN = "声音偏好设置"
}
enableInAHLabels = {
    enUS = "Enable in Auction House",
    esMX = "Habilitar en la Casa de Subastas",
    esES = "Habilitar en la Casa de Subastas",
    ptBR = "Ativar na Casa de Leilões",
    deDE = "Aktivieren im Auktionshaus",
    frFR = "Activer dans l'Hôtel des Ventes",
    itIT = "Attivare nella Casa d'Aste",
    ruRU = "Доступно в Aукционном Дом",
    koKR = "경매장에서 사용 가능",
    zhTW = "在拍賣行啟用",
    zhCN = "在拍卖行启用"
}
enableInAHTooltips = {
    enUS = "Enable or disable alerts for successful auctions\nwhen the auction house window is open",
    esMX = "Habilita o deshabilita las alertas para subastas exitosas\ncuando la ventana de la casa de subastas está abierta",
    esES = "Habilita o deshabilita las alertas para subastas exitosas\ncuando la ventana de la casa de subastas está abierta",
    ptBR = "Ativa ou desativa alertas para leilões bem-sucedidos\nquando a janela da casa de leilões está aberta",
    deDE = "Aktiviert oder deaktiviert Benachrichtigungen für erfolgreiche auktionen\nwenn das Auktionshaus-Fenster geöffnet ist",
    frFR = "Activer ou désactiver les alertes pour les ventes aux enchères réussies\nlorsque la fenêtre de l'hôtel des ventes est ouverte",
    itIT = "Abilitare o disabilitare gli avvisi per le aste andate a buon fine\nquando la finestra della casa d'aste è aperta.",
    ruRU = "Включение и отключение оповещений об успешных аукционах\nпри открытом окне аукционного дом",
    koKR = "경매장 창이 열려 있을 때 성공적인 경매에 대한 알림을\n사용하거나 사용하지 않도록 설정합니다.",
    zhTW = "在拍賣行視窗開啟時啟用或停用成功拍賣的警示",
    zhCN = "在拍卖行窗口打开时启用或禁用成功拍卖的警报"
}
enableExpired = {
    enUS = "Enable Expired Auction Alerts",
    esMX = "Activar Alertas de Subastas Expiradas",
    esES = "Activar Alertas de Subastas Expiradas",
    ptBR = "Ativar Alertas de Leilões Expirados",
    deDE = "Benachrichtigungen Über Abgelaufene Auktionen Aktivieren",
    frFR = "Activer les Alertes d'Enchères Expirées",
    itIT = "Abilitare gli Avvisi di Asta Scaduti",
    ruRU = "Включить Оповещений об Истечении Срока Действия Аукциона",
    koKR = "만료된 경매 알림 사용",
    zhTW = "啟用過期的競價提醒",
    zhCN = "启用过期的竞价提醒"
}
soundCategoryTexts = {
    enUS = "Sound Category",
    esMX = "Categoría de Sonido",
    esES = "Categoría de Sonido",
    ptBR = "Categoria de Som",
    deDE = "Soundkategorie",
    frFR = "Catégorie Sonore",
    itIT = "Categoria di Suono",
    ruRU = "Категория Звука",
    koKR = "소리 범주",
    zhTW = "音效類別",
    zhCN = "声音类别"
}
soundCategoryNames = {
    enUS = {
        "Coins",
        "Female Human",
        "Fireworks",
        "Impact",
        "Quests"
    },
    esMX = {
        "Monedas",
        "Humana",
        "Fuegos Artificiales",
        "Impacto",
        "Misiones"
    },
    esES = {
        "Monedas",
        "Humana",
        "Fuegos Artificiales",
        "Impacto",
        "Misiones"
    },
    ptBR = {
        "Moedas",
        "Humana",
        "Fogos de Artifício",
        "Impacto",
        "Missões"
    },
    deDE = {
        "Münzen",
        "Weiblicher Mensch",
        "Feuerwerk",
        "Einschlag",
        "Quests"
    },
    frFR = {
        "Pièces",
        "Humain Femme",
        "Feux d'artifice",
        "Impact",
        "Quêtes"
    },
    itIT = {
        "Monete",
        "Umana",
        "Fuochi d'artificio",
        "Impatto",
        "Missioni"
    },
    ruRU = {
        "Монеты",
        "Женщина",
        "Фейерверк",
        "Удар",
        "Заданий"
    },
    koKR = {
        "동전",
        "여성 인간",
        "불꽃놀이",
        "충격",
        "퀘스트"
    },
    zhTW = {
        "硬幣",
        "女性人類",
        "煙火",
        "衝擊",
        "任務"
    },
    zhCN = {
        "硬币",
        "女性人类",
        "烟花",
        "冲击",
        "任务"
    }
}
testSoundsTexts = {
    enUS = "Test Sounds",
    esMX = "Prueba de Sonidos",
    esES = "Prueba de Sonidos",
    ptBR = "Teste de Sons",
    deDE = "Geräuschtest",
    frFR = "Test de Sons",
    itIT = "Suoni di Prova",
    ruRU = "Тестовые Звуки",
    koKR = "테스트 사운드",
    zhTW = "測試音效",
    zhCN = "测试音效"
}
soundChannelTexts = {
    enUS = "Sound Channel",
    esMX = "Canal de Sonido",
    esES = "Canal de Sonido",
    ptBR = "Canal de Som",
    deDE = "Soundkanal",
    frFR = "Canal Sonore",
    itIT = "Canale Sonoro",
    ruRU = "Звуковой Канал",
    koKR = "음향 채널",
    zhTW = "音效頻道",
    zhCN = "声音通道"
}
soundChannelNames = {
    enUS = {
        "Master",
        "Sound",
        "Music",
        "Ambience",
        "Dialog"
    },
    esMX = {
        "Principal",
        "Sonido",
        "Música",
        "Ambiente",
        "Diálogo"
    },
    esES = {
        "Principal",
        "Sonido",
        "Música",
        "Ambiente",
        "Diálogo"
    },
    ptBR = {
        "Principal",
        "Som",
        "Música",
        "Ambiente",
        "Diálogo"
    },
    deDE = {
        "Haupt",
        "Ton",
        "Musik",
        "Umgebung",
        "Dialog"
    },
    frFR = {
        "Principal",
        "Son",
        "Musique",
        "Ambiance",
        "Dialogue"
    },
    itIT = {
        "Principale",
        "Suono",
        "Musica",
        "Ambiente",
        "Dialogo"
    },
    ruRU = {
        "Основной",
        "Звук",
        "Музыка",
        "Атмосфера",
        "Диалог"
    },
    koKR = {
        "마스터",
        "효과음",
        "음악",
        "환경음",
        "대화음"
    },
    zhTW = {
        "主音量",
        "音效",
        "音樂",
        "環境聲音",
        "對話"
    },
    zhCN = {
        "主音量",
        "音效",
        "音乐",
        "环境声音",
        "对话"
    }
}
soundChannelTooltips = {
    enUS = "The sound channel to be used by alerts",
    esMX = "El canal de sonido que se utilizará para las alertas",
    esES = "El canal de sonido que se utilizará para las alertas",
    ptBR = "O canal de som a ser usado pelas notificações",
    deDE = "Der soundkanal der von benachrichtigungen verwendet wird",
    frFR = "Le canal sonore à utiliser pour les alertes",
    itIT = "Il canale sonoro da utilizzare per gli avvisi",
    ruRU = "Звуковой канал который будет использоваться оповещениями",
    koKR = "알림에 사용할 음향 채널",
    zhTW = "警示所使用的音效頻道",
    zhCN = "用于警报的声音通道"
}
miscellaneousTexts = {
    enUS = "Miscellaneous",
    esMX = "Misceláneo",
    esES = "Misceláneo",
    ptBR = "Diversos",
    deDE = "Sonstiges",
    frFR = "Divers",
    itIT = "Varie",
    ruRU = "Разное",
    koKR = "기타",
    zhTW = "其他",
    zhCN = "杂项"
}
showGreetingMessageTexts = {
    enUS = "Show Greeting Message",
    esMX = "Mostrar Mensaje de Bienvenida",
    esES = "Mostrar Mensaje de Bienvenida",
    ptBR = "Mostrar Mensagem de Saudação",
    deDE = "Begrüßungsnachricht Anzeigen",
    frFR = "Afficher le Message de Bienvenue",
    itIT = "Mostra Messaggio di Saluto",
    ruRU = "Показать Приветственное Сообщение",
    koKR = "인사 메시지 표시",
    zhTW = "顯示問候訊息",
    zhCN = "显示问候消息"
}
