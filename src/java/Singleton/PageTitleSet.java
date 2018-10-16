/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Singleton;

import Srcs.PageTitle;

/**
 *
 * @author oditha
 */
public class PageTitleSet {

    private static PageTitle PAGE;

    public static PageTitle getTitle() {

        if (PAGE == null) {

            PAGE = new PageTitle();

        }

        return PAGE;

    }

}
