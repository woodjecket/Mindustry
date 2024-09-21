package mindustryX.mods.claj.dialogs

import arc.Core
import arc.graphics.Color
import arc.net.Client
import arc.scene.ui.layout.Cell
import arc.scene.ui.layout.Table
import arc.util.Http
import arc.util.serialization.Jval
import mindustry.Vars
import mindustry.gen.Icon
import mindustry.net.Host
import mindustry.ui.dialogs.BaseDialog
import mindustryX.mods.claj.ClajIntegration

class ManageRoomsDialog : BaseDialog("管理claj房间") {
    private var servers: List<ClajServer> = emptyList()
    private val list: Table

    init {
        addCloseButton()

        cont.defaults().width(if (Vars.mobile) 550f else 750f)

        this.list = cont.table().get()
        list.defaults().growX().padBottom(8f)
        list.update { list.cells.retainAll { cell: Cell<*> -> cell.get() != null } } // remove closed rooms
        cont.row()
        cont.labelWrap("复制Claj代码给你的朋友来联机").labelAlign(2, 8).padTop(16f).width(400f).get().style.fontColor = Color.lightGray

        shown {
            list.clearChildren()
            if (servers.isEmpty()) {
                list.add("获取可用服务器中，请稍后...")
                Http.get("http://p4.simpfun.cn:8667/client/servers") { res: Http.HttpResponse ->
                    servers = Jval.read(res.resultAsString).asArray().asIterable().map {
                        ClajServer(it.getString("address"), it.getInt("port", Vars.port))
                    }
                    Core.app.post { show() }
                }
            } else {
                servers.forEach {
                    list.add(it).row()
                    if (!it.hasChildren()) it.rebuild()
                }
            }
        }
    }

    internal data class ClajServer(val host: String, val port: Int, var link: String? = null) : Table() {
        private var ping: Result<Host>? = null
        private var client: Client? = null

        fun rebuild() {
            clearChildren()
            if (link != null) {
                add(link).fontScale(.7f).ellipsis(true).growX()
                button(Icon.copy, Vars.iconMed) {
                    Core.app.clipboardText = link
                    Vars.ui.showInfoFade("@copied")
                }
                button(Icon.cancel, Vars.iconMed) { this.close() }
            } else {
                add("$host:$port").growX()
                label {
                    val info = ping ?: return@label "Ping..."
                    info.getOrNull()?.let { "${it.ping}ms" } ?: "[red]Err"
                }
                button(Icon.refresh, Vars.iconMed, this::ping).disabled { ping == null }
                button(Icon.play, Vars.iconMed) {
                    try {
                        client = ClajIntegration.createRoom(host, port, { this.link = it!!;Core.app.post(this::rebuild) }, this::close)
                    } catch (e: Exception) {
                        Vars.ui.showErrorMessage(e.message)
                    }
                }.disabled { ping?.isSuccess != true || client != null }

                ping()
            }
        }

        fun ping() {
            ping = null
            Vars.net.pingHost(host, port, { ping = Result.success(it); }, { ping = Result.failure(it) })
        }

        private fun close() {
            client?.close()
            link = null
            client = null
            rebuild()
        }
    }
}