USE 'MBCS';

CREATE TABLE IF NOT EXISTS Offices (
    office_id INT UNSIGNED AUTO_INCREMENT,
    office_level ENUM('S', 'D', 'C') NOT NULL,
    higher_office_id INT UNSIGNED NOT NULL,
    name VARCHAR(60) NOT NULL,

    PRIMARY KEY (office_id),

    FOREIGN KEY (higher_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS OfficeRelationships (
    ofr_id INT UNSIGNED AUTO_INCREMENT,
    higher_office_id INT UNSIGNED NOT NULL,
    lower_office_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (ofr_id),

    FOREIGN KEY (higher_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (lower_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS Organizations (
    org_id INT UNSIGNED AUTO_INCREMENT,
    serve_office_id INT UNSIGNED NOT NULL,
    name VARCHAR(60) NOT NULL,
    
    PRIMARY KEY (org_id),

    FOREIGN KEY (serve_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS OrgRelationships (
    or_id INT UNSIGNED AUTO_INCREMENT,
    higher_org_id INT UNSIGNED NOT NULL,
    lower_org_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (or_id),

    FOREIGN KEY (higher_org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (lower_org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS IMUsers (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS Soldiers (
    soldier_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rank ENUM('CM', 'SD') NOT NULL,
    id_num CHAR(18) NOT NULL,
    name VARCHAR(30) NOT NULL,
    phone_num BIGINT UNSIGNED NOT NULL,
    wechat_openid VARCHAR(50),
    commander_id INT UNSIGNED NOT NULL,
    serve_office_id INT UNSIGNED NOT NULL,
    im_user_id INT UNSIGNED NOT NULL,

    FOREIGN KEY (commander_id) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (serve_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (im_user_id) 
    REFERENCES IMUsers(user_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS SoldierRelationships (
    sr_id INT UNSIGNED AUTO_INCREMENT,
    higher_sid INT UNSIGNED NOT NULL,
    lower_sid INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (sr_id),

    FOREIGN KEY (higher_sid) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (lower_sid) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS OrgSoldierRelationships (
    osr_id INT UNSIGNED AUTO_INCREMENT,
    serve_org_id INT UNSIGNED NOT NULL,
    soldier_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (osr_id),

    FOREIGN KEY (serve_org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (soldier_id) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS Admins (
    admin_id INT UNSIGNED AUTO_INCREMENT,
    admin_account VARCHAR(60) NOT NULL,
    admin_passwd CHAR(32) NOT NULL,
    admin_type ENUM('OF', 'OR') NOT NULL,
    im_user_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (admin_id),

    FOREIGN KEY (im_user_id) 
    REFERENCES IMUsers(user_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS OfficeAdminRelationships (
    ofar_id INT UNSIGNED AUTO_INCREMENT,
    admin_id INT UNSIGNED NOT NULL,
    office_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (ofar_id),

    FOREIGN KEY (admin_id) 
    REFERENCES Admins(admin_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS OrgAdminRelationships (
    orar_id INT UNSIGNED AUTO_INCREMENT,
    admin_id INT UNSIGNED NOT NULL,
    org_id INT UNSIGNED NOT NULL,
    leader_sid INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (orar_id),

    FOREIGN KEY (admin_id) 
    REFERENCES Admins(admin_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (leader_sid) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS Places (
    place_id INT UNSIGNED AUTO_INCREMENT,
    place_name VARCHAR(120) NOT NULL,
    place_lat DECIMAL(10, 8) NOT NULL,
    place_lng DECIMAL(11, 8) NOT NULL,
    
    PRIMARY KEY (place_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS Tasks (
    task_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(60) NOT NULL,
    mem_count INT UNSIGNED NOT NULL,
    launch_admin_id INT UNSIGNED NOT NULL,
    launch_datetime DATETIME NOT NULL DEFAULT NOW(),
    gather_datetime DATETIME NOT NULL,
    detail VARCHAR(500),
    gather_place_id INT UNSIGNED NOT NULL,
    finish_datetime DATETIME NOT NULL,
        
    PRIMARY KEY (task_id),

    FOREIGN KEY (launch_admin_id) 
    REFERENCES Admins(admin_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (gather_place_id) 
    REFERENCES Places(place_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS OrgPlaces (
    orp_id INT UNSIGNED AUTO_INCREMENT,
    org_id INT UNSIGNED NOT NULL,
    place_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (orp_id),

    FOREIGN KEY (org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (place_id) 
    REFERENCES Places(place_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS OfficePlaces (
    ofp_id INT UNSIGNED AUTO_INCREMENT,
    office_id INT UNSIGNED NOT NULL,
    place_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (ofp_id),

    FOREIGN KEY (office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (place_id) 
    REFERENCES Places(place_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS TaskAcceptOrgs (
    tao_id INT UNSIGNED AUTO_INCREMENT,
    ac_task_id INT UNSIGNED NOT NULL,
    ac_org_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (tao_id),

    FOREIGN KEY (ac_task_id) 
    REFERENCES Tasks(task_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (ac_org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS TaskAcceptOffices (
    taof_id INT UNSIGNED AUTO_INCREMENT,
    ac_task_id INT UNSIGNED NOT NULL,
    ac_office_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (taof_id),

    FOREIGN KEY (ac_task_id) 
    REFERENCES Tasks(task_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (ac_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS GatherNotifications (
    gn_id INT UNSIGNED AUTO_INCREMENT,
    gather_task_id INT UNSIGNED NOT NULL,
    recv_soldier_id INT UNSIGNED NOT NULL,
    read_status ENUM('UR', 'RF', 'AC') NOT NULL,
    res_datetime DATETIME DEFAULT NULL,
    
    PRIMARY KEY (gn_id),

    FOREIGN KEY (gather_task_id) 
    REFERENCES Tasks(task_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (recv_soldier_id) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS TaskSummarys (
    ts_id INT UNSIGNED AUTO_INCREMENT,
    sum_sid INT UNSIGNED NOT NULL,
    sum_tid INT UNSIGNED NOT NULL,
    sum_content VARCHAR(500) NOT NULL,
    
    PRIMARY KEY (ts_id),

    FOREIGN KEY (sum_sid) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (sum_tid) 
    REFERENCES Tasks(task_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS TaskCheckNames (
    tcn_id INT UNSIGNED AUTO_INCREMENT,
    check_task_id INT UNSIGNED NOT NULL,
    check_soidier_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (tcn_id),

    FOREIGN KEY (check_task_id) 
    REFERENCES Tasks(task_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (check_soidier_id) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS BroadcastMessages (
    bm_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(60) NOT NULL,
    detail VARCHAR(500),
    bm_type ENUM('GT', 'RM', 'CN') NOT NULL,
    wechat_notice BIT NOT NULL,
    sms_notice BIT NOT NULL,
    voice_notice BIT NOT NULL,
    
    PRIMARY KEY (bm_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS BcMsgOrgs (
    bmo_id INT UNSIGNED AUTO_INCREMENT,
    msg_id INT UNSIGNED NOT NULL,
    msg_org_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (bmo_id),

    FOREIGN KEY (msg_id) 
    REFERENCES BroadcastMessages(bm_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (msg_org_id) 
    REFERENCES Organizations(org_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS BcMsgOffices (
    bmo_id INT UNSIGNED AUTO_INCREMENT,
    msg_id INT UNSIGNED NOT NULL,
    msg_office_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (bmo_id),

    FOREIGN KEY (msg_id) 
    REFERENCES BroadcastMessages(bm_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (msg_office_id) 
    REFERENCES Offices(office_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS CommonNotifications (
    cn_id INT UNSIGNED AUTO_INCREMENT,
    cn_bm_id INT UNSIGNED NOT NULL,
    recv_soldier_id INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (cn_id),

    FOREIGN KEY (cn_bm_id) 
    REFERENCES BroadcastMessages(bm_id)
    ON DELETE RESTRICT,

    FOREIGN KEY (recv_soldier_id) 
    REFERENCES Soldiers(soldier_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE IF NOT EXISTS CmNtReceipts (
    cnr_id INT UNSIGNED AUTO_INCREMENT,
    cn_id INT UNSIGNED NOT NULL,
    rec_content VARCHAR(500),
    
    PRIMARY KEY (cnr_id),

    FOREIGN KEY (cn_id) 
    REFERENCES CommonNotifications(cn_id)
    ON DELETE RESTRICT

) ENGINE=InnoDB DEFAULT CHARSET=utf8;