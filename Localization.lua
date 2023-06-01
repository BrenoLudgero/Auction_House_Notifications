successfulAuctionMessages = {
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

failedAuctionMessages = {
    "Your auction of (.+) has expired%.", "You have been outbid on (.+)%.",                                             -- enUS
    "Tu subasta de (.+) ha caducado%.", "Alguien ha superado tu puja por (.+)%.", "Alguien ha pujado por tu (.+)%.",    -- esMX, esES
    "Votre vente aux enchères de (.+) est terminée", "Vous n'êtes plus le plus offrant pour (.+)%.",                    -- frFR
    "O leilão de (.+) expirou%.", "Superaram seu lance em (.+)%.",                                                      -- ptBR
    "Eure Auktion von (.+) ist abgelaufen%.", "Ihr wurdet bei (.+) überboten%.",                                        -- deDE
    "Ваш товар (.+) снят с аукциона%.", "(.+) предмет перекуплен%.",                                                    -- ruRU
    "(.+) 경매가 만료되었습니다%.", "(.+) 다른 플레이어에 의해 상회 입찰되었습니다%.",                                       -- koKR
    "你拍賣的(.+)已經過期。", "你對(.+)的出價被人超過了。",                                                                 -- zhTW
    "你拍卖的(.+)已经过期。", "你对(.+)的出价被人超过了。"                                                                  -- zhCN
}


local greetingMessages = { -- Messages to be shown when the addon loads depending on the client language
    enUS = "Auction House Notifications loaded successfully!",
    esMX = "¡Notificaciones de Casa de Subastas se ha cargado correctamente!",
    esES = "¡Notificaciones de Casa de Subastas se ha cargado correctamente!",
    ptBR = "Notificações da Casa de Leilões carregado com suscesso!",
    deDE = "Benachrichtigungen des Auktionshaus erfolgreich geladen!",
    frFR = "Notifications pour l'Hôtel des Ventes chargé avec succès!",
    ruRU = "Уведомления аукционного дом онлайн!",
    koKR = "경매장 알림 성공적으로 로드되었습니다!",
    zhTW = "拍賣行公告 載入成功！",
    zhCN = "拍卖行公告加载成功！"
}