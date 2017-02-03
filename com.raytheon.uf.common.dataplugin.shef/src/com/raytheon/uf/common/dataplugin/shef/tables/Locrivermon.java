/**
* This software was developed and / or modified by Raytheon Company,
* pursuant to Contract DG133W-05-CQ-1067 with the US Government.
* 
* U.S. EXPORT CONTROLLED TECHNICAL DATA
* This software product contains export-restricted data whose
* export/transfer/disclosure is restricted by U.S. law. Dissemination
* to non-U.S. persons whether in the United States or abroad requires
* an export license or other authorization.
* 
* Contractor Name:        Raytheon Company
* Contractor Address:     6825 Pine Street, Suite 340
*                         Mail Stop B8
*                         Omaha, NE 68106
*                         402.291.0100
* 
* See the AWIPS II Master Rights File ("Master Rights File.pdf") for
* further licensing information.
**/
package com.raytheon.uf.common.dataplugin.shef.tables;
// default package
// Generated Oct 17, 2008 2:22:17 PM by Hibernate Tools 3.2.2.GA

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Locrivermon generated by hbm2java
 * 
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Oct 17, 2008                        Initial generation by hbm2java
 * Aug 19, 2011      10672     jkorman Move refactor to new project
 * Oct 07, 2013       2361     njensen Removed XML annotations
 * 
 * </pre>
 * 
 * @author jkorman
 * @version 1.1
 */
@Entity
@Table(name = "locrivermon")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Locrivermon extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private LocrivermonId id;

    public Locrivermon() {
    }

    public Locrivermon(LocrivermonId id) {
        this.id = id;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "lid", column = @Column(name = "lid", length = 8)),
            @AttributeOverride(name = "name", column = @Column(name = "name", length = 50)),
            @AttributeOverride(name = "county", column = @Column(name = "county", length = 20)),
            @AttributeOverride(name = "state", column = @Column(name = "state", length = 2)),
            @AttributeOverride(name = "hsa", column = @Column(name = "hsa", length = 3)),
            @AttributeOverride(name = "stream", column = @Column(name = "stream", length = 32)),
            @AttributeOverride(name = "bankfull", column = @Column(name = "bankfull", precision = 17, scale = 17)),
            @AttributeOverride(name = "actionStage", column = @Column(name = "action_stage", precision = 17, scale = 17)),
            @AttributeOverride(name = "floodStage", column = @Column(name = "flood_stage", precision = 17, scale = 17)),
            @AttributeOverride(name = "floodFlow", column = @Column(name = "flood_flow", precision = 17, scale = 17)),
            @AttributeOverride(name = "actionFlow", column = @Column(name = "action_flow", precision = 17, scale = 17)),
            @AttributeOverride(name = "primaryPe", column = @Column(name = "primary_pe", length = 2)),
            @AttributeOverride(name = "proximity", column = @Column(name = "proximity", length = 6)),
            @AttributeOverride(name = "reach", column = @Column(name = "reach", length = 80)),
            @AttributeOverride(name = "mile", column = @Column(name = "mile", precision = 17, scale = 17)),
            @AttributeOverride(name = "minor", column = @Column(name = "minor", precision = 17, scale = 17)),
            @AttributeOverride(name = "moderate", column = @Column(name = "moderate", precision = 17, scale = 17)),
            @AttributeOverride(name = "major", column = @Column(name = "major", precision = 17, scale = 17)) })
    public LocrivermonId getId() {
        return this.id;
    }

    public void setId(LocrivermonId id) {
        this.id = id;
    }

}