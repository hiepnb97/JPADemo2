/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.*;

@Entity
@Table(name = "SE12345")

/**
 *
 * @author hiepn
 */
public class SE12345 {
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    private String projectID;
    private String name;
    private int quality;
    private boolean feature;

    public SE12345() {
    }

    public SE12345(String projectID, String name, int quality, boolean feature) {
        this.projectID = projectID;
        this.name = name;
        this.quality = quality;
        this.feature = feature;
    }

    
    // getters/setters
    
    public String getProjectID() {
        return projectID;
    }

    public void setProjectID(String projectID) {
        this.projectID = projectID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuality() {
        return quality;
    }

    public void setQuality(int quality) {
        this.quality = quality;
    }

    public boolean isFeature() {
        return feature;
    }

    public void setFeature(boolean feature) {
        this.feature = feature;
    }
    
    
}
