local versionNumber = GetAddOnMetadata("AuctionHouseNotifications", "Version")  -- Gets the addon version number from the .toc file and saves it in a variable

successfulAuctionMessages = {  -- Patterns to be scanned on CHAT_MSG_SYSTEM
    "Your auction of (.+) sold%.", "You won an auction for (.+)",                                   -- enUS
    "Has vendido (.+) en la subasta%.", "Has ganado una puja por (.+)", "Tu (.+) se ha vendido%.",  -- esMX, esES
    "Vente de votre (.+) réussie", "Vous avez gagné les enchères pour (.+)",                        -- frFR
    "Você vendeu (.+) no leilão%.", "Você ganhou um leilão de (.+)",                                -- ptBR
    "Versteigerung: (.+) wurde verkauft%.", "Ihr habt eine Auktion gewonnen für: (.+)",             -- deDE
    "На ваш товар (.+) нашелся покупатель%.", "(.+) предмет куплен. Вы выиграли торги%.",           -- ruRU
    "경매에 올린 (.+) 판매되었습니다%.", "(.+) 경매에 낙찰되었습니다%.",                                -- koKR
    "你拍賣的(.+)已經售出。", "你贏得了(.+)的競標",                                                    -- zhTW
    "你拍卖的(.+)已经售出。", "你赢得了对(.+)的竞标"                                                   -- zhCN
}

failedAuctionMessages = {  -- Patterns to be scanned on CHAT_MSG_SYSTEM
    "Your auction of (.+) has expired%.", "You have been outbid on (.+)%.",                                           -- enUS
    "Tu subasta de (.+) ha caducado%.", "Alguien ha superado tu puja por (.+)%.", "Alguien ha pujado por tu (.+)%.",  -- esMX, esES
    "Votre vente aux enchères de (.+) est terminée", "Vous n'êtes plus le plus offrant pour (.+)%.",                  -- frFR
    "O leilão de (.+) expirou%.", "Superaram seu lance em (.+)%.",                                                    -- ptBR
    "Eure Auktion von (.+) ist abgelaufen%.", "Ihr wurdet bei (.+) überboten%.",                                      -- deDE
    "Ваш товар (.+) снят с аукциона%.", "(.+) предмет перекуплен%.",                                                  -- ruRU
    "(.+) 경매가 만료되었습니다%.", "(.+) 다른 플레이어에 의해 상회 입찰되었습니다%.",                                     -- koKR
    "你拍賣的(.+)已經過期。", "你對(.+)的出價被人超過了。",                                                               -- zhTW
    "你拍卖的(.+)已经过期。", "你对(.+)的出价被人超过了。"                                                                -- zhCN
}

addonTitles = {  -- Localized title to be used in the in-game addon options interface
    enUS = "Auction House Notifications",
    esMX = "Notificaciones de Casa de Subastas",
    esES = "Notificaciones de Casa de Subastas",
    ptBR = "Notificações da Casa de Leilões",
    deDE = "Benachrichtigungen des Auktionshaus",
    frFR = "Notifications pour l'Hôtel des Ventes",
    ruRU = "Уведомления Aукционного Дом",
    koKR = "경매장 알림",
    zhTW = "拍賣行公告",
    zhCN = "拍卖行公告"
}

greetingMessages = { -- Localized message to be shown in the chat when the addon loads
    enUS = "|cFFFFFF00Auction House Notifications|r loaded successfully! (" ..versionNumber.. ")",
    esMX = "¡|cFFFFFF00Notificaciones de Casa de Subastas|r se ha cargado correctamente! (" ..versionNumber.. ")",
    esES = "¡|cFFFFFF00Notificaciones de Casa de Subastas|r se ha cargado correctamente! (" ..versionNumber.. ")",
    ptBR = "|cFFFFFF00Notificações da Casa de Leilões|r carregado com sucesso! (" ..versionNumber.. ")",
    deDE = "|cFFFFFF00Benachrichtigungen des Auktionshaus|r erfolgreich geladen! (" ..versionNumber.. ")",
    frFR = "|cFFFFFF00Notifications pour l'Hôtel des Ventes|r chargé avec succès! (" ..versionNumber.. ")",
    ruRU = "|cFFFFFF00Уведомления Aукционного Дом|r онлайн! (" ..versionNumber.. ")",
    koKR = "|cFFFFFF00경매장 알림|r 성공적으로 로드되었습니다! (" ..versionNumber.. ")",
    zhTW = "|cFFFFFF00拍賣行公告|r 載入成功！(" ..versionNumber.. ")",
    zhCN = "|cFFFFFF00拍卖行公告|r 加载成功！(" ..versionNumber.. ")"
}

subtitleText = {
    enUS = "Created by Breno Ludgero\nVersion " ..versionNumber,
    esMX = "Creado por Breno Ludgero\nVersión " ..versionNumber,
    esES = "Creado por Breno Ludgero\nVersión " ..versionNumber,
    ptBR = "Criado por Breno Ludgero\nVersão " ..versionNumber,
    deDE = "Erstellt von Breno Ludgero\nVersion " ..versionNumber,
    frFR = "Créé par Breno Ludgero\nVersion " ..versionNumber,
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
    deDE = "Im Auktionshaus aktivieren",
    frFR = "Activer dans la Hôtel des Ventes",
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
    frFR = "Activer ou désactiver les alertes pour les enchères\nréussies lorsque la fenêtre de l'hôtel des ventes est ouverte",
    ruRU = "Включение и отключение оповещений об успешных аукционах\nпри открытом окне аукционного дом",
    koKR = "경매장 창이 열려 있을 때 성공적인 경매에 대한 알림을\n사용하거나 사용하지 않도록 설정합니다.",
    zhTW = "在拍賣行視窗開啟時啟用或停用成功拍賣的警示",
    zhCN = "在拍卖行窗口打开时启用或禁用成功拍卖的警报"
}

soundCategoryTexts = {
    enUS = "Sound Category",
    esMX = "Categoría de Sonido",
    esES = "Categoría de Sonido",
    ptBR = "Categoria de Som",
    deDE = "Soundkategorie",
    frFR = "Catégorie Sonore",
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
    "Impact"
},
esMX = {
    "Monedas",
    "Humano Femenino",
    "Fuegos Artificiales",
    "Impacto"
},
esES = {
    "Monedas",
    "Humano Femenino",
    "Fuegos Artificiales",
    "Impacto"
},
ptBR = {
    "Moedas",
    "Humano Feminino",
    "Fogos de Artifício",
    "Impacto"
},
deDE = {
    "Münzen",
    "Weiblicher Mensch",
    "Feuerwerk",
    "Einschlag"
},
frFR = {
    "Pièces",
    "Humain Femme",
    "Feux d'artifice",
    "Impact"
},
ruRU = {
    "Монеты",
    "Женщина",
    "Фейерверк",
    "Удар"
},
koKR = {
    "동전",
    "여성 인간",
    "불꽃놀이",
    "충격"
},
zhTW = {
    "硬幣",
    "女性人類",
    "煙火",
    "衝擊"
},
zhCN = {
    "硬币",
    "女性人类",
    "烟花",
    "冲击"
}}

soundChannelTexts = {
    enUS = "Sound Channel",
    esMX = "Canal de Sonido",
    esES = "Canal de Sonido",
    ptBR = "Canal de Som",
    deDE = "Soundkanal",
    frFR = "Canal Sonore",
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
}}

soundChannelTooltips = {
    enUS = "The sound channel to be used by alerts",
    esMX = "El canal de sonido que se utilizará para las alertas",
    esES = "El canal de sonido que se utilizará para las alertas",
    ptBR = "O canal de som a ser usado pelas notificações",
    deDE = "Der Soundkanal der von benachrichtigungen verwendet wird",
    frFR = "Le canal sonore à utiliser pour les alertes",
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
    ruRU = "Показать Приветственное Сообщение",
    koKR = "인사 메시지 표시",
    zhTW = "顯示問候訊息",
    zhCN = "显示问候消息"
}

warningTexts = {
    enUS = "|cFFFF0000Note:|r An interface reload is necessary for changes to take effect",
    esMX = "|cFFFF0000Nota:|r Es necesario recargar la interfaz para que los cambios surtan efecto",
    esES = "|cFFFF0000Nota:|r Es necesario recargar la interfaz para que los cambios surtan efecto",
    ptBR = "|cFFFF0000Nota:|r É necessário recarregar a interface para que as alterações tenham efeito",
    deDE = "|cFFFF0000Notiz:|r Eine Schnittstellenneuladung ist erforderlich damit Änderungen wirksam werden",
    frFR = "|cFFFF0000Note :|r Un rechargement de l'interface est nécessaire pour que les modifications prennent effet",
    ruRU = "|cFFFF0000Примечание:|r Для применения изменений необходимо перезагрузить интерфейс",
    koKR = "|cFFFF0000참고:|r 변경 사항이 적용되려면 인터페이스를 다시 로드해야 합니다",
    zhTW = "|cFFFF0000注意：|r 需要重新載入介面才能生效",
    zhCN = "|cFFFF0000注意：|r 需要重新加载界面才能生效"
}

reloadUIButtonTexts = {
    enUS = "Reload Interface",
    esMX = "Recargar Interfaz",
    esES = "Recargar Interfaz",
    ptBR = "Recarregar Interface",
    deDE = "Schnittstelle neu Laden",
    frFR = "Recharger l'Interface",
    ruRU = "Перезагрузить Интерфейс",
    koKR = "인터페이스 다시 로드",
    zhTW = "重新載入介面",
    zhCN = "重新加载界面"
}
