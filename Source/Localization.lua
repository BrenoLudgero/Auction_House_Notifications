local _, ahn = ...
local L = ahn.L

if ahn.locale == "enUS" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r loaded successfully! ("..ahn.version..")"
    L.subtitle = "Created by "..ahn.author.."\nVersion "..ahn.version
    L.soundPreferences = "Sound Preferences"
    L.enableInAHText = "Enable in Auction House"
    L.enableInAHTooltip = "Enable or disable alerts for successful auctions\nwhen the auction house window is open"
    L.enableExpired = "Enable Expired Auction Alerts"
    L.successfulSoundText = "Successful Auction"
    L.failedSoundText = "Failed Auction"
    L.expiredSoundText = "Expired Auction"
    L.successfulText = "Success"
    L.failedText = "Failure"
    L.expiredText = "Expiration"
    L.soundCategoryNames = {
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
    L.testSounds = "Test Sounds"
    L.soundChannelText = "Sound Channel"
    L.soundChannelNames = {
        "Master",
        "Effects",
        "Music",
        "Ambience",
        "Dialog"
    }
    L.soundChannelTooltip = "The sound channel to be used by alerts"
    L.miscellaneous = "Miscellaneous"
    L.showGreetingMessage = "Show Greeting Message"
    return

elseif ahn.locale == "esMX" or ahn.locale == "esES" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r ¡se ha cargado correctamente! ("..ahn.version..")"
    L.subtitle = "Creado por "..ahn.author.."\nVersión "..ahn.version
    L.soundPreferences = "Preferencias de Sonido"
    L.enableInAHText = "Habilitar en la Casa de Subastas"
    L.enableInAHTooltip = "Habilita o deshabilita las alertas para subastas exitosas\ncuando la ventana de la casa de subastas está abierta"
    L.enableExpired = "Activar Alertas de Subastas Expiradas"
    L.successfulSoundText = " Subasta Exitosa"
    L.failedSoundText = "Subasta Fallida"
    L.expiredSoundText = "Subasta Expirada"
    L.successfulText = "Éxito"
    L.failedText = "Fracaso"
    L.expiredText = "Expiración"
    L.soundCategoryNames = {
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
    L.testSounds = "Prueba de Sonidos"
    L.soundChannelText = "Canal de Sonido"
    L.soundChannelNames = {
        "Principal",
        "Efectos",
        "Música",
        "Ambiente",
        "Diálogo"
    }
    L.soundChannelTooltip = "El canal de sonido que se utilizará para las alertas"
    L.miscellaneous = "Misceláneo"
    L.showGreetingMessage = "Mostrar Mensaje de Bienvenida"
    return

elseif ahn.locale == "ptBR" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r carregado com sucesso! ("..ahn.version..")"
    L.subtitle = "Criado por "..ahn.author.."\nVersão "..ahn.version
    L.soundPreferences = "Preferências de Som"
    L.enableInAHText = "Ativar na Casa de Leilões"
    L.enableInAHTooltip = "Ativa ou desativa alertas para leilões bem-sucedidos\nquando a janela da casa de leilões está aberta"
    L.enableExpired = "Ativar Alertas de Leilões Vencidos"
    L.successfulSoundText = "Leilão Bem-Sucedido"
    L.failedSoundText = "Leilão Mal-Sucedido"
    L.expiredSoundText = "Leilão Vencido"
    L.successfulText = "Sucesso"
    L.failedText = "Fracasso"
    L.expiredText = "Vencimento"
    L.soundCategoryNames = {
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
    L.testSounds = "Teste de Sons"
    L.soundChannelText = "Canal de Som"
    L.soundChannelNames = {
        "Principal",
        "Efeitos",
        "Música",
        "Ambiente",
        "Diálogo"
    }
    L.soundChannelTooltip = "O canal de som a ser usado pelas notificações"
    L.miscellaneous = "Diversos"
    L.showGreetingMessage = "Mostrar Mensagem de Saudação"
    return

elseif ahn.locale == "deDE" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r erfolgreich geladen! ("..ahn.version..")"
    L.subtitle = "Erstellt von "..ahn.author.."\nVersion "..ahn.version
    L.soundPreferences = "Soundeinstellungen"
    L.enableInAHText = "Aktivieren im Auktionshaus"
    L.enableInAHTooltip = "Aktiviert oder deaktiviert Benachrichtigungen für erfolgreiche Auktionen\nwenn das Auktionshaus-Fenster geöffnet ist"
    L.enableExpired = "Benachrichtigungen Über Abgelaufene Auktionen Aktivieren"
    L.successfulSoundText = "Erfolgreiche Auktion"
    L.failedSoundText = "Fehlgeschlagene Auktion"
    L.expiredSoundText = "Abgelaufene Auktion"
    L.successfulText = "Erfolgreich"
    L.failedText = "Fehlgeschlagen"
    L.expiredText = "Abgelaufen"
    L.soundCategoryNames = {
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
    L.testSounds = "Geräuschtest"
    L.soundChannelText = "Soundkanal"
    L.soundChannelNames = {
        "Haupt",
        "Effekte",
        "Musik",
        "Umgebung",
        "Dialog"
    }
    L.soundChannelTooltip = "Der Soundkanal, der von Benachrichtigungen verwendet wird"
    L.miscellaneous = "Sonstiges"
    L.showGreetingMessage = "Begrüßungsnachricht Anzeigen"
    return

elseif ahn.locale == "frFR" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r chargé avec succès! ("..ahn.version..")"
    L.subtitle = "Créé par "..ahn.author.."\nVersion "..ahn.version
    L.soundPreferences = "Préférences Sonores"
    L.enableInAHText = "Activer dans l'Hôtel des Ventes"
    L.enableInAHTooltip = "Activer ou désactiver les alertes pour les ventes aux enchères réussies\nlorsque la fenêtre de l'hôtel des ventes est ouverte"
    L.enableExpired = "Activer les Alertes d'Enchères Expirées"
    L.successfulSoundText = "Enchère Réussie"
    L.failedSoundText = "Enchère Infructueuse"
    L.expiredSoundText = "Enchère Expirée"
    L.successfulText = "Succès"
    L.failedText = "Infructueuse"
    L.expiredText = "Expiration"
    L.soundCategoryNames = {
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
    L.testSounds = "Test de Sons"
    L.soundChannelText = "Canal Sonore"
    L.soundChannelNames = {
        "Principal",
        "Effets",
        "Musique",
        "Ambiance",
        "Dialogue"
    }
    L.soundChannelTooltip = "Le canal sonore à utiliser pour les alertes"
    L.miscellaneous = "Divers"
    L.showGreetingMessage = "Afficher le Message de Bienvenue"
    return

elseif ahn.locale == "itIT" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r sono state aperte con successo! ("..ahn.version..")"
    L.subtitle = "Creato da "..ahn.author.."\nVersion "..ahn.version
    L.soundPreferences = "Preferenze di Suono"
    L.enableInAHText = "Attivare nella Casa d'Aste"
    L.enableInAHTooltip = "Abilitare o disabilitare gli avvisi per le aste andate a buon fine\nquando la finestra della casa d'aste è aperta"
    L.enableExpired = "Abilitare gli Avvisi di Aste Scadute"
    L.successfulSoundText = "Asta di Successo"
    L.failedSoundText = "Asta Fallita"
    L.expiredSoundText = "Asta Scaduta"
    L.successfulText = "Successo"
    L.failedText = "Fallimento"
    L.expiredText = "Scadenza"
    L.soundCategoryNames = {
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
    L.testSounds = "Suoni di Prova"
    L.soundChannelText = "Canale Sonoro"
    L.soundChannelNames = {
        "Principale",
        "Effetti",
        "Musica",
        "Ambiente",
        "Dialogo"
    }
    L.soundChannelTooltip = "Il canale sonoro da utilizzare per gli avvisi"
    L.miscellaneous = "Varie"
    L.showGreetingMessage = "Mostra Messaggio di Saluto"
    return

elseif ahn.locale == "ruRU" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r онлайн! ("..ahn.version..")"
    L.subtitle = "Создано "..ahn.author.."\nВерсия "..ahn.version
    L.soundPreferences = "Настройки Звука"
    L.enableInAHText = "Доступно в Aукционном Дом"
    L.enableInAHTooltip = "Включение и отключение оповещений об успешных аукционах\nпри открытом окне аукционного дом"
    L.enableExpired = "Включить оповещения о просроченных аукционах"
    L.successfulSoundText = "Успешный Aукцион"
    L.failedSoundText = "Несостоявшийся Aукцион"
    L.expiredSoundText = "Просроченный Aукцион"
    L.successfulText = "Успешный"
    L.failedText = "Несостоявшийся"
    L.expiredText = "Просроченный"
    L.soundCategoryNames = {
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
    L.testSounds = "Тестовые Звуки"
    L.soundChannelText = "Звуковой Канал"
    L.soundChannelNames = {
        "Основной",
        "Эффекты",
        "Музыка",
        "Атмосфера",
        "Диалог"
    }
    L.soundChannelTooltip = "Звуковой канал который будет использоваться оповещениями"
    L.miscellaneous = "Разное"
    L.showGreetingMessage = "Показать Приветственное Сообщение"
    return

elseif ahn.locale == "koKR" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r 성공적으로 로드되었습니다! ("..ahn.version..")"
    L.subtitle = ahn.author.."에 의해 생성됨\n버전 "..ahn.version
    L.soundPreferences = "소리 설정"
    L.enableInAHText = "경매장에서 사용 가능"
    L.enableInAHTooltip = "경매장 창이 열려 있을 때 성공적인 경매에 대한 알림을\n사용하거나 사용하지 않도록 설정합니다."
    L.enableExpired = "만료된 경매 알림 사용"
    L.successfulSoundText = "성공적인 경매"
    L.failedSoundText = "실패한 경매"
    L.expiredSoundText = "만료된 경매"
    L.successfulText = "성공"
    L.failedText = "실패"
    L.expiredText = "만료"
    L.soundCategoryNames = {
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
    L.testSounds = "테스트 사운드"
    L.soundChannelText = "음향 채널"
    L.soundChannelNames = {
        "마스터",
        "효과",
        "음악",
        "환경음",
        "대화음"
    }
    L.soundChannelTooltip = "알림에 사용할 음향 채널"
    L.miscellaneous = "기타"
    L.showGreetingMessage = "인사 메시지 표시"
    return

elseif ahn.locale == "zhTW" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r 載入成功！("..ahn.version..")"
    L.subtitle = "由"..ahn.author.."創建\n版本 "..ahn.version
    L.soundPreferences = "音效偏好設定"
    L.enableInAHText = "在拍賣行啟用"
    L.enableInAHTooltip = "在拍賣行視窗開啟時\n啟用或停用成功拍賣的警示"
    L.enableExpired = "啟用過期的競價提醒"
    L.successfulSoundText = "成功拍賣"
    L.failedSoundText = "拍賣失敗"
    L.expiredSoundText = "已過期的拍賣"
    L.successfulText = "成功"
    L.failedText = "失敗"
    L.expiredText = "已過期"
    L.soundCategoryNames = {
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
    L.testSounds = "測試音效"
    L.soundChannelText = "音效頻道"
    L.soundChannelNames = {
        "主音量",
        "效果",
        "音樂",
        "環境聲音",
        "對話"
    }
    L.soundChannelTooltip = "警示所使用的音效頻道"
    L.miscellaneous = "其他"
    L.showGreetingMessage = "顯示問候訊息"
    return

elseif ahn.locale == "zhCN" then
    L.greetingMessage = "|cFFFFFF00"..L.title.."|r加载成功！("..ahn.version..")"
    L.subtitle = "由"..ahn.author.."创建\n版本 "..ahn.version
    L.soundPreferences = "声音偏好设置"
    L.enableInAHText = "在拍卖行启用"
    L.enableInAHTooltip = "在拍卖行窗口打开时\n启用或禁用成功拍卖的警报"
    L.enableExpired = "启用过期的竞价提醒"
    L.successfulSoundText = "成功拍卖"
    L.failedSoundText = "拍卖失败"
    L.expiredSoundText = "已过期的拍卖"
    L.successfulText = "成功"
    L.failedText = "失败"
    L.expiredText = "已过期"
    L.soundCategoryNames = {
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
    L.testSounds = "测试音效"
    L.soundChannelText = "声音通道"
    L.soundChannelNames = {
        "主音量",
        "效果",
        "音乐",
        "环境声音",
        "对话"
    }
    L.soundChannelTooltip = "用于警报的声音通道"
    L.miscellaneous = "杂项"
    L.showGreetingMessage = "显示问候消息"
end
