class_name summoningWindow
extends ExtendedWindow

func summon(daemon: Daemon):
	if daemon in player.stats.stock and player.stats.hexbytes >= daemon.summonCost:
		player.stats.stock.erase(daemon)
		player.stats.activeStock.append(daemon)
		player.stats.hexbytes -= daemon.summonCost
		player.stockUpdated.emit()
