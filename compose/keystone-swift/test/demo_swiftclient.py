#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 vince <vince@tang-pc>
#
# Distributed under terms of the MIT license.

from contextlib import contextmanager
from swiftclient.client import Connection as SwiftConnection


@contextmanager
def swift_conn(authurl, user, project, password):
    '''
    authurl : http://keystone:5000
    user: aaa
    project: aaa
    password: bbb
    '''

    # by default add http schema
    if not authurl.startswith("http"):
        authurl = "http://" + authurl

    os_options = {"tenant_name": project}
    conn = SwiftConnection(authurl=authurl,
                           user=user,
                           key=password,
                           os_options=os_options,
                           auth_version=3)
    conn.get_auth()
    yield conn
    conn.close()

if __name__ == "__main__":
    with swift_conn("127.0.0.1:5000", "home", "home", "123456") as conn:
        __import__('ipdb').set_trace()
        conn.get_account()
        conn.put_container("testing")
        conn.put_object("testing","test001", "123456")
        header, content = conn.get_object("testing", "test001")

