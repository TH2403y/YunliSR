const std = @import("std");
const protocol = @import("protocol");
const CmdID = protocol.CmdID;
const Session = @import("../Session.zig");
const Packet = @import("../Packet.zig");
const Allocator = std.mem.Allocator;

const log = std.log.scoped(.scene_service);

pub fn onGetCurSceneInfo(session: *Session, _: *const Packet, allocator: Allocator) !void {
    var scene_info = protocol.SceneInfo.init(allocator);
    scene_info.game_mode_type = 1;
    scene_info.plane_id = 20241;
    scene_info.floor_id = 20241001;
    scene_info.entry_id = 2024101;

    { // Character
        var scene_group = protocol.SceneGroupInfo.init(allocator);
        scene_group.state = 1;

        try scene_group.entity_list.append(.{
            .entity = .{
                .actor = .{
                    .base_avatar_id = 1221,
                    .avatar_type = .AVATAR_FORMAL_TYPE,
                    .uid = 1337,
                    .map_layer = 2,
                },
            },
            .motion = .{ .pos = .{ .x = 32342, .y = 192820, .z = 434276 }, .rot = .{} },
        });

        try scene_info.scene_group_list.append(scene_group);
    }
    try session.send(CmdID.CmdSceneEntityMoveScRsp, protocol.SceneEntityMoveScRsp{
        .retcode = 0,
        .entity_motion_list = req.entity_motion_list,
        .download_data = null,
    });
}
