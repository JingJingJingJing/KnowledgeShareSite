rs.initiate(
    {
        _id: "rs",
        version: 1,
        members: [
            {_id: 0,host: "app_data1:27017",priority: 99},
            {_id: 1,host: "app_data2:27017",priority: 1},
            {_id: 2,host: "app_data3:27017",priority: 1}
        ]
    }
)