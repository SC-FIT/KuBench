package com.bp.experiment.dao.model;

import org.hibernate.annotations.ColumnDefault;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "\"user\"")
public class User {
    @Id
    @ColumnDefault("nextval('user_id_seq')")
    @Column(name = "id", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "group_id", nullable = false)
    private Group group;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "state_id", nullable = false)
    private Usergroupstate state;

    @NotNull
    @Column(name = "name", nullable = false, length = Integer.MAX_VALUE)
    private String name;

    @NotNull
    @Column(name = "surname", nullable = false, length = Integer.MAX_VALUE)
    private String surname;

    @NotNull
    @Column(name = "login", nullable = false, length = Integer.MAX_VALUE)
    private String login;

    @Column(name = "passwd", length = Integer.MAX_VALUE)
    private String passwd;

    @NotNull
    @Column(name = "email", nullable = false, length = Integer.MAX_VALUE)
    private String email;

    @Column(name = "phone", length = Integer.MAX_VALUE)
    private String phone;

    @NotNull
    @Column(name = "is_dsm_admin", nullable = false)
    private Boolean isDsmAdmin = false;

    @NotNull
    @Column(name = "is_group_admin", nullable = false)
    private Boolean isGroupAdmin = false;

    @NotNull
    @Column(name = "is_planner", nullable = false)
    private Boolean isPlanner = false;

    @NotNull
    @Column(name = "is_support_tech", nullable = false)
    private Boolean isSupportTech = false;

    @Column(name = "photo", length = Integer.MAX_VALUE)
    private String photo;

}