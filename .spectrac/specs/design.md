# design.md

Purpose
- High-level architecture, component interactions, and sequence diagrams. (See directives.md Section 3.2 for full rules).

## Overview
- Components:
  - {Component 1}: {Responsibility}
  - {Component 2}: {Responsibility}

## Sequence diagram (Mermaid)
```mermaid
sequenceDiagram
  participant User
  participant ComponentA
  participant ComponentB
  User->>ComponentA: {Action}
  ComponentA->>ComponentB: {Data Flow}
  ComponentB-->>User: {Response}
