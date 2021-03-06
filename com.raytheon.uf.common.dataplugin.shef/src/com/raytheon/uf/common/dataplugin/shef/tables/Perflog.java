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
 * Perflog generated by hbm2java
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
@Table(name = "perflog")
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Perflog extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private PerflogId id;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Integer numProcessed;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Integer numReads;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Integer numInserts;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Integer numUpdates;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Integer numDeletes;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double elapsedTime;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double cpuTime;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double ioTime;

    public Perflog() {
    }

    public Perflog(PerflogId id) {
        this.id = id;
    }

    public Perflog(PerflogId id, Integer numProcessed, Integer numReads,
            Integer numInserts, Integer numUpdates, Integer numDeletes,
            Double elapsedTime, Double cpuTime, Double ioTime) {
        this.id = id;
        this.numProcessed = numProcessed;
        this.numReads = numReads;
        this.numInserts = numInserts;
        this.numUpdates = numUpdates;
        this.numDeletes = numDeletes;
        this.elapsedTime = elapsedTime;
        this.cpuTime = cpuTime;
        this.ioTime = ioTime;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "process", column = @Column(name = "process", nullable = false, length = 10)),
            @AttributeOverride(name = "startTime", column = @Column(name = "start_time", nullable = false, length = 29)) })
    public PerflogId getId() {
        return this.id;
    }

    public void setId(PerflogId id) {
        this.id = id;
    }

    @Column(name = "num_processed")
    public Integer getNumProcessed() {
        return this.numProcessed;
    }

    public void setNumProcessed(Integer numProcessed) {
        this.numProcessed = numProcessed;
    }

    @Column(name = "num_reads")
    public Integer getNumReads() {
        return this.numReads;
    }

    public void setNumReads(Integer numReads) {
        this.numReads = numReads;
    }

    @Column(name = "num_inserts")
    public Integer getNumInserts() {
        return this.numInserts;
    }

    public void setNumInserts(Integer numInserts) {
        this.numInserts = numInserts;
    }

    @Column(name = "num_updates")
    public Integer getNumUpdates() {
        return this.numUpdates;
    }

    public void setNumUpdates(Integer numUpdates) {
        this.numUpdates = numUpdates;
    }

    @Column(name = "num_deletes")
    public Integer getNumDeletes() {
        return this.numDeletes;
    }

    public void setNumDeletes(Integer numDeletes) {
        this.numDeletes = numDeletes;
    }

    @Column(name = "elapsed_time", precision = 17, scale = 17)
    public Double getElapsedTime() {
        return this.elapsedTime;
    }

    public void setElapsedTime(Double elapsedTime) {
        this.elapsedTime = elapsedTime;
    }

    @Column(name = "cpu_time", precision = 17, scale = 17)
    public Double getCpuTime() {
        return this.cpuTime;
    }

    public void setCpuTime(Double cpuTime) {
        this.cpuTime = cpuTime;
    }

    @Column(name = "io_time", precision = 17, scale = 17)
    public Double getIoTime() {
        return this.ioTime;
    }

    public void setIoTime(Double ioTime) {
        this.ioTime = ioTime;
    }

}
